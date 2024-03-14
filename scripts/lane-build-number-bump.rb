# Make sure that the current branch is `develop` before running this script
# It should create a new branch from `develop`
# It will run a fastlane lane called qa_build which creates the build, bumps the build number
# Pushes the changes to the remote branch
# Open a PR to `develop`
# The PR should have the title `QA Build {new_build_number}` and a generic description describing the changes
# The PR should be assigned to the user who ran the script
# The PR should be labeled with `QA`

# Get the current branch
current_branch = `git rev-parse --abbrev-ref HEAD`.strip
if current_branch != 'develop'
    puts "You must be on the `develop` branch to run this script"
    exit 1
end

# Get the current build number
# Run the fastlane command and get its output
output = `fastlane run get_build_number`.strip

# Use a regular expression to extract the build number
match = output.match(/Result: (\d+)/)

# If a match was found, the build number is the first (and only) capture group
build_number = match[1] if match

puts "Current build number: #{build_number}"


# Bump the build number
new_build_number = build_number.to_i + 1
puts "New build number: #{new_build_number}"
