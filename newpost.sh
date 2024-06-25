#!/bin/bash

content_dir="./content/blog"

# Create a new post directory with an index.md.
create_post_directory() {
    read -p "Enter the name of the new post directory (ex: my-new-post): " dir_name
    read -p "Enter the title: " title
    read -p "Enter the description: " description

    # Create the directory.
    mkdir -p "$content_dir/$dir_name"
    # Create the post inside the directory.
    touch "$content_dir/$dir_name/index.md"
    write_front_matter "$content_dir/$dir_name/index.md" "$title" "$description"
    echo "Post directory '$dir_name' created successfully."
}

# Create a new post.
create_post() {
    read -p "Enter the filename (ex: my-new-post): " file_name
    read -p "Enter the title: " title
    read -p "Enter the description: " description

    # Create the file
    touch "$content_dir/$file_name.md"
    write_front_matter "$content_dir/$file_name.md" "$title" "$description"
    echo "Post '$file_name.md' created successfully."
}

# Add front matter to the markdown file.
write_front_matter() {
    local file_path="$1"
    local title="$2"
    local description="$3"
    timestamp="$(date -u +%Y-%m-%d)"
    cat << EOF > $file_path
+++
title = "${title}"
description = "${description}"
date = ${timestamp}
draft = true

[taxonomies]
tags = []
+++
EOF
}

# Main.
echo "Choose an option:"
echo "1. Create a new post"
echo "2. Create a new post directory"

read -p "Enter your choice (1 or 2): " choice

case $choice in
    1)
        create_post
        ;;
    2)
        create_post_directory
        ;;
    *)
        echo "Invalid choice. Please run the script again and select 1 or 2."
        ;;
esac
