-- Run this whole file in Supabase Dashboard > SQL Editor > New query.
create table if not exists public.tracks (
  id uuid primary key default gen_random_uuid(),
  user_id uuid not null references auth.users(id) on delete cascade,
  title text not null check (char_length(title) between 1 and 100),
  artist_name text not null check (char_length(artist_name) between 1 and 100),
  storage_path text not null,
  status text not null default 'pending' check (status in ('pending','approved','rejected')),
  plays bigint not null default 0,
  created_at timestamptz not null default now()
);
alter table public.tracks enable row level security;
drop policy if exists "Anyone can read approved tracks" on public.tracks;
create policy "Anyone can read approved tracks" on public.tracks for select using (status = 'approved' or auth.uid() = user_id);
drop policy if exists "Artists can submit own tracks" on public.tracks;
create policy "Artists can submit own tracks" on public.tracks for insert to authenticated with check (auth.uid() = user_id and status = 'pending');
drop policy if exists "Artists can edit own pending tracks" on public.tracks;
create policy "Artists can edit own pending tracks" on public.tracks for update to authenticated using (auth.uid() = user_id and status = 'pending') with check (auth.uid() = user_id and status = 'pending');
-- Create a public Storage bucket for approved music playback.
insert into storage.buckets (id,name,public,file_size_limit,allowed_mime_types)
values ('songs','songs',true,26214400,array['audio/mpeg','audio/mp3','audio/mp4','audio/aac','audio/wav','audio/ogg','audio/flac','audio/x-wav'])
on conflict (id) do update set public = true, file_size_limit = 26214400, allowed_mime_types = excluded.allowed_mime_types;
drop policy if exists "Artists upload to their own folder" on storage.objects;
create policy "Artists upload to their own folder" on storage.objects for insert to authenticated with check (bucket_id = 'songs' and (storage.foldername(name))[1] = auth.uid()::text);
drop policy if exists "Public can read song files" on storage.objects;
create policy "Public can read song files" on storage.objects for select using (bucket_id = 'songs');
drop policy if exists "Artists can delete own song files" on storage.objects;
create policy "Artists can delete own song files" on storage.objects for delete to authenticated using (bucket_id = 'songs' and (storage.foldername(name))[1] = auth.uid()::text);
