#!/bin/sh

echo -n "Please enter project name in snake_case: "
read sk

echo -n "Please enter project name in CamelCase: "
read cc

rm -rf ./.git

for file in $(find . -name "*starting_template*"); do
    mv $file `echo $file | sed s/starting_template/$sk/`;
done

find . -type f -exec sed -i `s/starting_template/$sk/g` {} +
find . -type f -exec sed -i `s/StartingTemplate/$cc/g` {} +

rm -rf ./template.sh