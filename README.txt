PLAY PAY MUSIC — FREE STARTER FOR CLOUDFLARE PAGES + SUPABASE

This is an early free launch build, not a full Audiomack replacement.
It provides a responsive public website, Supabase artist registration/login,
artist audio uploads (25 MB max), pending moderation, approved song listing,
playback and direct download links.

IMPORTANT LIMITS / HONEST NOTES
- Supabase Free currently includes 1 GB file storage and 5 GB egress; a project may pause after 7 days of very low activity. Check current limits.
- Free service quotas can change. This cannot guarantee permanent free hosting or unlimited listeners/uploads.
- The songs bucket is public so visitors can stream approved songs. Pending uploads are not listed on the site, but their file URLs are not private.
- There is no royalty calculation or artist payout feature. The displayed play count is a simple counter, not verified royalty-grade accounting.
- An admin must approve/reject songs manually in Supabase Table Editor. Do not advertise earnings until proper royalty, fraud, legal and payment systems exist.

SETUP
1. Create a Supabase project on the Free plan.
2. In Supabase > SQL Editor, run the complete supabase_setup.sql file.
3. In Supabase > Project Settings > API, copy the Project URL and anon/public key.
4. Open index.html and replace SUPABASE_URL and SUPABASE_ANON_KEY placeholders. Never use the service_role key.
5. Upload index.html and supabase_setup.sql to the ROOT of your GitHub repository (the repository's main page). README.txt is optional.
6. In Cloudflare Dashboard > Workers & Pages > Create > Pages > Connect to Git, select the GitHub repository. Framework preset: None. Build command: leave blank. Build output directory: / (root).
7. Deploy. Cloudflare gives a free pages.dev address.

MODERATION
Open Supabase > Table Editor > tracks. Change status from pending to approved or rejected. Only approved tracks show publicly.

SECURITY
Never publish a Supabase service_role key. Only use the anon/public key in the browser. Enable email confirmation in Supabase Auth. Review uploads for copyright and harmful content.
