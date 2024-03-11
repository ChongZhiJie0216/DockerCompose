#!/bin/bash
# Run the Before script
/root/DockerCompose_Stop.bash
# Specify source directory
source_dir="/root/Docker-Compose/"
# Specify target root directory
target_root="/root/Backup-tmp/"
# Specify number of cores to use
num_cores=24
# Get current date and format it as YYYY-MM-DD@HH.MM
current_date=$(date "+%Y-%m-%d@%H.%M")
# Build target directory path
target_dir="$target_root/$current_date"
# Ensure target directory exists, create if it doesn't
mkdir -p "$target_dir"
# Record start time
start_time=$(date "+%Y-%m-%d %H:%M:%S")
echo "[$start_time] Starting backup process" >> "$target_dir/Logs.txt"
echo "[$start_time] Starting backup process"
# Traverse through subdirectories in the source directory
for subdir in "$source_dir"/*/; do
    # Get subdirectory name
    subdir_name=$(basename "$subdir")
    # Output current subdirectory being processed
    current_time=$(date "+%Y-%m-%d %H:%M:%S")
    echo "[$current_time] Backing Up: $subdir_name" >> "$target_dir/Logs.txt"
    echo "[$current_time] Backing Up: $subdir_name"
    # Record start time of compressing subdirectory
    subdir_start_time=$(date "+%Y-%m-%d %H:%M:%S")
    # Get uncompressed size of subdirectory
    uncompressed_size_before=$(du -sh "$subdir" | awk '{print $1}')
    # Compress subdirectory specifying number of cores
    tar -cf - -C "$source_dir" "$subdir_name" | pigz -p "$num_cores" > "$target_dir/$subdir_name.tar.gz"
    # Record end time of compressing subdirectory
    subdir_end_time=$(date "+%Y-%m-%d %H:%M:%S")
    # Calculate duration of compressing subdirectory
    subdir_duration=$(date -u -d @"$(( $(date -d "$subdir_end_time" +%s) - $(date -d "$subdir_start_time" +%s) ))" "+%H:%M:%S")
    # Get compressed size of subdirectory
    compressed_size_after=$(du -sh "$target_dir/$subdir_name.tar.gz" | awk '{print $1}')
    # Output compressing duration and sizes of subdirectory
    echo "[$subdir_end_time] Backing Up: $subdir_name completed in $subdir_duration (Before: $uncompressed_size_before, After: $compressed_size_after)" >> "$target_dir/Logs.txt"
    echo "[$subdir_end_time] Backing Up: $subdir_name completed in $subdir_duration (Before: $uncompressed_size_before, After: $compressed_size_after)"
done

# Remove old backup directories (older than 7 days)
find "$target_root" -mindepth 1 -maxdepth 1 -type d -mtime +7 -exec rm -rf {} \;

# Record end time
end_time=$(date "+%Y-%m-%d %H:%M:%S")
echo "[$end_time] Done" >> "$target_dir/Logs.txt"
echo "[$end_time] Done"

# Run the next script
/root/DockerCompose_Start.bash