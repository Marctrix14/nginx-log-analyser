# Download the access log
log_file=$(mktemp) # creates a temporary file and stores its path in log_file
curl -sSL https://gist.githubusercontent.com/kamranahmedse/e66c3b9ea89a1a030d3b739eeeef22d0/raw/77fb3ac837a73c4f0206e78a236d885590b7ae35/nginx-access.log > "$log_file"

# Analyze the log
# Top 5 IP addresses
echo -e "Top 5 IP addresses with the most requests:"
awk '{ print $1 }' "$log_file" | sort | uniq -c | sort -nr | head -5 | while read count ip; do echo "$ip - $count requests"; done
#The previous pipeline processes the access log, extracts IP addresses, sorts them, counts occurrences, and selects the top 5

# Top 5 most requested paths
echo -e "\nTop 5 most requested paths:"
awk '{ print $7 }' "$log_file" | sort | uniq -c | sort -nr | head -5 | while read count path; do echo "$path - $count requests"; done

# Top 5 response status codes
echo -e "\nTop 5 response status codes:"
awk '{ print $9 }' "$log_file" | sort | uniq -c | sort -nr | head -5 | while read count status_code; do echo "$status_code - $count requests"; done

# Top 5 user agents
echo -e "\nTop 5 user agents:"
awk '{ print $12 }' "$log_file" | sort | uniq -c | sort -nr | head -5 | while read count user_agent; do echo "$user_agent - $count requests"; done

# Clean up the temporary file
rm "$log_file"