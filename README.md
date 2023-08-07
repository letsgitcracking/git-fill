# Git History Filler

The Git History Filler script is a shell script that automatically generates a commit history for a Git repository. The commit history is generated for a specified range of dates and at a specified commit level, which determines the number of commits made per day.

## Usage

To use the Git History Filler, run the following command in your terminal:

```bash
./script.sh <start date> <end date> <commit level>
```

## Arguments

The script accepts the following arguments:

- `<start date>`: The date from which to start generating the commit history. This should be in the format YYYY-MM-DD.

- `<end date>`: The date up to which to generate the commit history. This should be in the format YYYY-MM-DD. The end date cannot be in the future.

- `<commit level>`: The level of commit activity. This can be low, medium, or high. The commit level determines the range of commits made per day:
  - low: 1-3 commits on weekdays, 0-1 commits on weekends
  - medium: 1-5 commits on weekdays, 0-2 commits on weekends
  - high: 2-9 commits on weekdays, 0-2 commits on weekends
## Example

To generate a commit history from January 1, 2022 to December 31, 2022 with a high level of commit activity, run the following command:

```bash
./script.sh 2022-01-01 2022-12-31 high
```

This will create a commit history in your Git repository where each commit modifies a file named git-fill.txt. The number of commits per day will range from 2 to 9 on weekdays and from 0 to 2 on weekends.

## Setup and Requirements
Before running the script, make sure that:

1 - You have Git installed. If not, you can install it with the following command:

```bash
sudo apt update
sudo apt install git
```

2 - You are in the root directory of the Git repository you want to fill with commit history. You can initialize a new repository with these commands:

```bash
Copy code
mkdir my_repository
cd my_repository
git init
```
3 - The script file script.sh is in the same directory and it has execute permissions. You can make the script executable with the following command:

```bash
Copy code
chmod +x script.sh
```

## Limitations

1 - The script only works on Unix-like systems, such as Linux or MacOS. It has not been tested on Windows.

2 - The script only creates a commit history in the current Git repository.

3 - The git-fill.txt file is used as a placeholder for the commits, but it doesn't contain any meaningful content.

4 - The commit messages are automatically generated and don't convey meaningful changes.

## License

This project is licensed under the MIT License.