# hosts

Manages custom entries in `/etc/hosts` so they provision automatically and sync
across your devices.

## How it works

`install.sh` maintains a **managed block** inside `/etc/hosts`, delimited by
marker comments:

```
# BEGIN DOTFILES MANAGED HOSTS
...generated entries...
# END DOTFILES MANAGED HOSTS
```

Everything between the markers is regenerated from scratch on every run, so the
script is idempotent (safe to re-run). Anything outside the markers — `localhost`,
the section Docker Desktop manages, etc. — is left untouched. A backup of the
previous file is written to `/etc/hosts.dotfiles.bak` before any change.

The block is assembled from two files:

| File          | In git?                    | Purpose                                                                                              |
| ------------- | -------------------------- | ---------------------------------------------------------------------------------------------------- |
| `hosts`       | ✅ committed (public repo) | Entries safe to publish. Syncs to every device via git — this is what auto-provisions a new machine. |
| `hosts.local` | ❌ gitignored (`*.local`)  | Optional overlay for entries you'd rather not publish.                                               |

## What goes where

Because this repository is **public**, `hosts` is world-readable. Put entries
there when you're comfortable publishing them:

- **Loopback dev hosts** (`127.0.0.1 hypha.test`) — not sensitive at all.
- **LAN convenience hosts** (`192.168.1.11 nas.local`) — these map a name to a
  private, unroutable address. Publishing one costs a little privacy (a public
  record of your home-network naming), not access, and in return the entry
  provisions automatically on every device. That trade is usually worth it.

Reserve `hosts.local` for entries that are genuinely don't-publish: a routable
IP, a VPN endpoint, a client host — anything that leaks access or a relationship
you don't want indexed. **Never** put credentials in either file; a hosts file
is world-readable on your machine. Secrets belong in `local/config.json`.

## Usage

```bash
# Edit the shared entries...
vi ~/.dotfiles/hosts/hosts

# ...and/or add private ones (optional)
cp ~/.dotfiles/hosts/hosts.local.example ~/.dotfiles/hosts/hosts.local
vi ~/.dotfiles/hosts/hosts.local

# Apply to /etc/hosts (prompts for sudo only if something changed)
~/.dotfiles/hosts/install.sh
```

`install.sh` also runs automatically as part of `bootstrap.sh`.

## Note: `.local` and mDNS/Bonjour

The `.local` suffix is the mDNS/Bonjour domain. Many devices (Synology, Home
Assistant, most routers) already advertise a `.local` name on the network, so
`ping nas.local` may resolve with **no** hosts entry at all. A static `/etc/hosts`
entry _overrides_ mDNS — which is handy when mDNS is flaky, but means the entry
must be updated if the device's DHCP-assigned IP changes. For rock-solid names,
give these devices a DHCP reservation (static lease) on your router.

## Optionally syncing `hosts.local` across devices

Because `hosts.local` is gitignored, git won't sync it. If you keep private
entries and want them on every machine, put the real file in a synced folder and
symlink it:

```bash
mv ~/.dotfiles/hosts/hosts.local ~/Maestral/Code/hosts.local
ln -s ~/Maestral/Code/hosts.local ~/.dotfiles/hosts/hosts.local
```

Dropbox/Maestral then keeps it in sync without it ever entering the public repo.
