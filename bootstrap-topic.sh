#!/usr/bin/env bash
#
# Run a single topic's installation
#
# Usage:
#   ./bootstrap-topic.sh <topic>  # e.g., ./bootstrap-topic.sh claude
#
set +e

cd "$(dirname "$0")"

# Source shared functions
source "./lib/functions.sh"

TOPIC="$1"

if [ -z "$TOPIC" ]; then
	echo "Usage: ./bootstrap-topic.sh <topic>"
	echo ""
	echo "Available topics:"
	for dir in */; do
		if [ -f "${dir}install.sh" ] || [ -f "${dir}preinstall.sh" ]; then
			echo "  ${dir%/}"
		fi
	done
	exit 1
fi

topic_dir="./$TOPIC"

if [ ! -d "$topic_dir" ]; then
	fail "Topic '$TOPIC' not found (no directory at $topic_dir)"
fi

info "Bootstrapping topic: $TOPIC"

# Run preinstall.sh if it exists
if [ -f "$topic_dir/preinstall.sh" ]; then
	info "Running ${topic_dir}/preinstall.sh"
	if sh -c "${topic_dir}/preinstall.sh"; then
		success "Completed ${topic_dir}/preinstall.sh"
	else
		warn "Failed ${topic_dir}/preinstall.sh"
	fi
fi

# Run install.sh if it exists
if [ -f "$topic_dir/install.sh" ]; then
	info "Running ${topic_dir}/install.sh"
	if sh -c "${topic_dir}/install.sh"; then
		success "Completed ${topic_dir}/install.sh"
	else
		fail "Failed ${topic_dir}/install.sh"
	fi
else
	warn "No install.sh found for topic '$TOPIC'"
fi

success "Topic '$TOPIC' bootstrapped"
