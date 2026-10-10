# 🌀 Slang Labyrinth

A 3D browser game that teaches 40 modern English slang terms. Escape 5 labyrinths by decoding slang gates while the Devourer hunts you, or study in the **Training Ground**.

No build step. Pure static files (three.js loads from a CDN).

## Features
- 3D maze runner: gates, traps, hints, chasing monster, 5 levels, optional global timer
- Training Ground: multiple choice, fill the gap, and **speak it** (browser speech recognition + text-to-speech), lives, per-question timer, mastery tracking (3 correct in a row)
- Profiles: username, login count, history, per-user mastery
- Optional shared stats for the owner: visits, unique visitors, users, logins, activity (`admin.html`)

## Run locally
Open `index.html`, or `python3 -m http.server` and visit http://localhost:8000 (the microphone needs `localhost` or HTTPS).

## Publish on GitHub Pages
1. Create a public repo and upload every file in this folder.
2. Settings > Pages > Deploy from branch > `main` / root.
3. Your game: `https://<user>.github.io/<repo>/`, dashboard: `.../admin.html`.

## Enable visit and user stats (optional, free tier is enough)
GitHub Pages is static, so shared stats need a small backend. This project uses Supabase:
1. Create a project at supabase.com.
2. SQL Editor: run `supabase.sql`.
3. Authentication > Providers > Email: **turn OFF "Allow new users to sign up"**, then Authentication > Users > *Add user* with your own email and password (this is your admin login).
4. Project Settings > API: copy the Project URL and the `anon` public key into `config.js`.
5. Commit, then open `admin.html` and sign in.

Without step 4, everything works but `admin.html` only shows data from the browser you open it in.

## What is recorded
Random visitor ID, username, event type (visit, signup, login, training session, level cleared, maze over/won), scores, and a truncated user-agent. No IP address is stored by this code. Show a privacy notice if you publish publicly, and honor deletion requests (delete rows by username in Supabase).

## Known limits
- Usernames have **no password**: anyone can type any name, and names are not unique across devices. Fine for a learning game, not for anything sensitive.
- Anyone can insert events through the public key (spam is limited by size checks only). Add rate limiting or a Supabase Edge Function if it gets abused.
- Speech recognition works in Chrome, Edge and Safari; not Firefox. Accuracy for slang words varies, so the match threshold is 75% of the sentence.
- Heavy 3D shadows may lag on low-end phones.

## Content
Slang definitions and example sentences come from the author's own slide deck.
