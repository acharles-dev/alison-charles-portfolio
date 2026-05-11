# alison-charles-portfolio

Personal portfolio site powered by [Supabase](https://supabase.com) as a headless CMS.

**Live:** [link TBD]

## Supabase Features Used

- **Database (Postgres)** for all content: profile, experience, case studies, writing samples
- **Auth** for admin panel (update content without redeploying)
- **Row Level Security** public read, authenticated write

## Setup

1. Create a Supabase project at [supabase.com](https://supabase.com)
2. Run the migration in `supabase/migrations/001_initial_schema.sql`
3. Run the seed data in `supabase/seed.sql`
4. Copy your project URL and anon key into `index.html`
5. Deploy to Vercel: `vercel --prod`

## Stack

- Vanilla HTML/CSS/JS (no build step)
- Supabase JS client via CDN
- Deployed on Vercel

## Why Supabase

Postgres is more than a portfolio needs. That's the point. The same setup that serves a personal site scales to powering a full content platform. Supabase makes the overkill painless.
