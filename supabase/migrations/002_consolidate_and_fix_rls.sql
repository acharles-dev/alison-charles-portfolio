-- ============================================================
-- Consolidated schema: all three projects in one Supabase instance
-- Fixes RLS: anon = read only, writes require authenticated or service_role
-- ============================================================

-- ============================================================
-- PORTFOLIO TABLES (already exist from 001, just fix RLS)
-- ============================================================

-- Drop broken policies
drop policy if exists "Public read profile" on profile;
drop policy if exists "Auth update profile" on profile;
drop policy if exists "Public read experience" on experience;
drop policy if exists "Auth manage experience" on experience;
drop policy if exists "Public read case_studies" on case_studies;
drop policy if exists "Auth manage case_studies" on case_studies;
drop policy if exists "Public read writing_samples" on writing_samples;
drop policy if exists "Auth manage writing_samples" on writing_samples;

-- Portfolio: anon reads, authenticated writes
create policy "anon_read" on profile for select to anon using (true);
create policy "auth_write" on profile for all to authenticated using (true);

create policy "anon_read" on experience for select to anon using (true);
create policy "auth_write" on experience for all to authenticated using (true);

create policy "anon_read" on case_studies for select to anon using (true);
create policy "auth_write" on case_studies for all to authenticated using (true);

create policy "anon_read" on writing_samples for select to anon using (true);
create policy "auth_write" on writing_samples for all to authenticated using (true);

-- ============================================================
-- LINK-INTEL TABLES (new in this project)
-- ============================================================

create table if not exists competitors (
  id uuid primary key default gen_random_uuid(),
  name text not null,
  slug text unique not null,
  website text,
  logo_emoji text,
  category text default 'Link Management',
  created_at timestamptz default now()
);

create table if not exists signals (
  id uuid primary key default gen_random_uuid(),
  competitor_id uuid references competitors(id) on delete cascade,
  signal_type text not null check (signal_type in ('blog', 'changelog', 'pricing', 'feature')),
  title text not null,
  summary text,
  source_url text,
  detected_at timestamptz default now(),
  dedup_hash text unique
);

create table if not exists snapshots (
  id uuid primary key default gen_random_uuid(),
  competitor_id uuid references competitors(id) on delete cascade,
  snapshot_type text not null,
  data jsonb,
  captured_at timestamptz default now()
);

create index if not exists idx_signals_detected on signals(detected_at desc);
create index if not exists idx_signals_competitor on signals(competitor_id);
create index if not exists idx_signals_type on signals(signal_type);

alter table competitors enable row level security;
alter table signals enable row level security;
alter table snapshots enable row level security;

-- Link-intel: anon reads only. Writes come from Edge Functions via service_role (bypasses RLS).
create policy "anon_read" on competitors for select to anon using (true);
create policy "anon_read" on signals for select to anon using (true);
create policy "anon_read" on snapshots for select to anon using (true);

-- ============================================================
-- PMM DIGEST TABLES (new in this project)
-- ============================================================

create table if not exists sources (
  id uuid primary key default gen_random_uuid(),
  name text not null,
  feed_url text,
  source_type text default 'rss' check (source_type in ('rss', 'atom')),
  category text default 'pmm',
  active boolean default true,
  last_fetched_at timestamptz
);

create table if not exists articles (
  id uuid primary key default gen_random_uuid(),
  source_id uuid references sources(id) on delete cascade,
  title text not null,
  url text not null,
  author text,
  summary text,
  published_at timestamptz,
  fetched_at timestamptz default now(),
  dedup_hash text unique,
  included_in_digest boolean default false
);

create table if not exists digests (
  id uuid primary key default gen_random_uuid(),
  digest_date date unique not null,
  article_count int default 0,
  html_content text,
  sent_at timestamptz,
  email_status text default 'pending' check (email_status in ('pending', 'ready', 'sent', 'failed'))
);

create index if not exists idx_articles_fetched on articles(fetched_at desc);
create index if not exists idx_articles_unsent on articles(included_in_digest) where included_in_digest = false;
create index if not exists idx_digests_date on digests(digest_date desc);

alter table sources enable row level security;
alter table articles enable row level security;
alter table digests enable row level security;

-- PMM digest: anon reads only. Writes come from Edge Functions via service_role.
create policy "anon_read" on sources for select to anon using (true);
create policy "anon_read" on articles for select to anon using (true);
create policy "anon_read" on digests for select to anon using (true);
