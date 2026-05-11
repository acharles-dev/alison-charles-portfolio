# alison-charles-portfolio

Personal portfolio site powered by [Supabase](https://supabase.com) as a database backend.

**Live:** [alison-charles-portfolio.vercel.app](https://alison-charles-portfolio.vercel.app)

## Supabase Features Used

- **Database (Postgres)** for work experience, case studies, and writing samples
- **Row Level Security** — public read via anon key, writes restricted to authenticated/service_role

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
