#!/usr/bin/env bash
set -e
source ~/.dotfiles/lib/functions.sh

check_command jenv

info "Setting up jenv"

# Check if any JDKs are installed
JDK_COUNT=$(find /Library/Java/JavaVirtualMachines -maxdepth 1 -name '*jdk*' -type d 2> /dev/null | wc -l | tr -d ' ')

if [ "$JDK_COUNT" -eq 0 ]; then
	warn "No JDKs found in /Library/Java/JavaVirtualMachines"
	warn "Install a JDK before running this script"
	exit 0
fi

info "Found $JDK_COUNT JDK(s), adding to jenv"

for d in /Library/Java/JavaVirtualMachines/*jdk*/; do
	if [ -d "$d/Contents/Home" ]; then
		info "Adding $(basename "$d")"
		jenv add "$d/Contents/Home/" || warn "$(basename "$d") may already be added"
	fi
done

success "jenv configured"
