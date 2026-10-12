-- MONSTART 35 — exécuter dans Supabase > SQL Editor > New query.
-- Les tables sont protégées par RLS : chaque utilisateur n'accède qu'à ses lignes.
create extension if not exists pgcrypto;
create table if not exists public.profiles (
  id uuid primary key references auth.users(id) on delete cascade,
  display_name text not null default '', grade text not null default '', station text not null default '',
  phone text not null default '', skills text not null default '', updated_at timestamptz not null default now()
);
create table if not exists public.shifts (
  id uuid primary key default gen_random_uuid(), user_id uuid not null references auth.users(id) on delete cascade,
  title text not null, type text not null default 'Autre', start_date date not null, start_time time not null,
  end_date date not null, end_time time not null, place text not null default '', notes text not null default '',
  reminder boolean not null default true, updated_at timestamptz not null default now(), created_at timestamptz not null default now(),
  constraint shift_dates_valid check (end_date >= start_date)
);
create table if not exists public.vehicles (
  id uuid primary key default gen_random_uuid(), user_id uuid not null references auth.users(id) on delete cascade,
  name text not null, type text not null default 'Autre', station text not null default '',
  status text not null default 'À vérifier', km integer, fuel integer, next_service date, notes text not null default '',
  updated_at timestamptz not null default now(), created_at timestamptz not null default now(),
  constraint vehicle_km_valid check (km is null or km >= 0), constraint vehicle_fuel_valid check (fuel is null or fuel between 0 and 100)
);
alter table public.profiles enable row level security;
alter table public.shifts enable row level security;
alter table public.vehicles enable row level security;
drop policy if exists "profile own row select" on public.profiles;
create policy "profile own row select" on public.profiles for select to authenticated using (auth.uid() = id);
drop policy if exists "profile own row insert" on public.profiles;
create policy "profile own row insert" on public.profiles for insert to authenticated with check (auth.uid() = id);
drop policy if exists "profile own row update" on public.profiles;
create policy "profile own row update" on public.profiles for update to authenticated using (auth.uid() = id) with check (auth.uid() = id);
drop policy if exists "shifts own rows select" on public.shifts;
create policy "shifts own rows select" on public.shifts for select to authenticated using (auth.uid() = user_id);
drop policy if exists "shifts own rows insert" on public.shifts;
create policy "shifts own rows insert" on public.shifts for insert to authenticated with check (auth.uid() = user_id);
drop policy if exists "shifts own rows update" on public.shifts;
create policy "shifts own rows update" on public.shifts for update to authenticated using (auth.uid() = user_id) with check (auth.uid() = user_id);
drop policy if exists "shifts own rows delete" on public.shifts;
create policy "shifts own rows delete" on public.shifts for delete to authenticated using (auth.uid() = user_id);
drop policy if exists "vehicles own rows select" on public.vehicles;
create policy "vehicles own rows select" on public.vehicles for select to authenticated using (auth.uid() = user_id);
drop policy if exists "vehicles own rows insert" on public.vehicles;
create policy "vehicles own rows insert" on public.vehicles for insert to authenticated with check (auth.uid() = user_id);
drop policy if exists "vehicles own rows update" on public.vehicles;
create policy "vehicles own rows update" on public.vehicles for update to authenticated using (auth.uid() = user_id) with check (auth.uid() = user_id);
drop policy if exists "vehicles own rows delete" on public.vehicles;
create policy "vehicles own rows delete" on public.vehicles for delete to authenticated using (auth.uid() = user_id);
-- Pas de politique publique : aucun compte ne peut lire les lignes des autres.
