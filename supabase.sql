-- Run once in Supabase: Dashboard > SQL Editor > New query > paste > Run.
create table if not exists public.events (
  id         bigint generated always as identity primary key,
  created_at timestamptz not null default now(),
  visitor    text  check (length(visitor)  <= 64),
  username   text  check (length(username) <= 32),
  type       text  not null check (length(type) <= 32),
  data       jsonb check (pg_column_size(data) < 4000),
  ua         text  check (length(ua) <= 200)
);
create index if not exists events_created_idx on public.events (created_at desc);
alter table public.events enable row level security;

-- Players (anonymous) may ONLY add events. They can never read or change anything.
create policy "anyone can log events" on public.events for insert to anon with check (true);
-- Only a signed-in admin (Supabase Auth user) can read.
create policy "admin can read events" on public.events for select to authenticated using (true);
