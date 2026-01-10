SSH_KEY="$HOME/.ssh/id_ed25519"

# Check if the key already exists
if [ ! -f "$SSH_KEY" ]; then
	echo "🛠  SSH key not found. Generating a new one..."
	ssh-keygen -t ed25519 -C "$USER_EMAIL" -f "$SSH_KEY" -N ""
	echo "✅ SSH key generated at $SSH_KEY"
else
	echo "🔑 SSH key already exists at $SSH_KEY"
fi
