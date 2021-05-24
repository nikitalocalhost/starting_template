# StartingTemplate

## How to start with this template

1. Clone it: `git clone https://github.com/nikitalocalhost/starting_template.git new_name`
2. Go to project folder: `cd new_name`
3. Delete .git folder: `rm -rf .git`
4. Rename all files in directory: `` for file in $(find . -name "*starting_template*"); do mv $file `echo $file | sed s/starting_template/new_name/`; done  ``
5. Rename all file contents: `find . -type f -print0 | xargs -0 sed -i 's/starting_template/new_name/g'` and `find . -type f -print0 | xargs -0 sed -i 's/StartingTemplate/NewName/g'`
