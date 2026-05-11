-- Portfolio CMS schema

create table profile (
  id int primary key default 1 check (id = 1),
  name text not null,
  headline text,
  bio text,
  location text,
  linkedin_url text,
  email text,
  updated_at timestamptz default now()
);

create table experience (
  id uuid primary key default gen_random_uuid(),
  company text not null,
  company_context text,
  title text not null,
  start_date text,
  end_date text,
  bullets jsonb default '[]',
  sort_order int default 0
);

create table case_studies (
  id uuid primary key default gen_random_uuid(),
  title text not null,
  company text,
  summary text,
  challenge text,
  approach text,
  result text,
  url text,
  sort_order int default 0
);

create table writing_samples (
  id uuid primary key default gen_random_uuid(),
  title text not null,
  sample_type text,
  url text,
  description text,
  company text,
  sort_order int default 0
);

-- RLS: public read, authenticated write
alter table profile enable row level security;
alter table experience enable row level security;
alter table case_studies enable row level security;
alter table writing_samples enable row level security;

create policy "Public read profile" on profile for select using (true);
create policy "Auth update profile" on profile for update using (auth.role() = 'authenticated');

create policy "Public read experience" on experience for select using (true);
create policy "Auth manage experience" on experience for all using (auth.role() = 'authenticated');

create policy "Public read case_studies" on case_studies for select using (true);
create policy "Auth manage case_studies" on case_studies for all using (auth.role() = 'authenticated');

create policy "Public read writing_samples" on writing_samples for select using (true);
create policy "Auth manage writing_samples" on writing_samples for all using (auth.role() = 'authenticated');
