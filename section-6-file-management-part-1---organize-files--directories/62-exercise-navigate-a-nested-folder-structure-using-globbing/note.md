## 62. Exercise: Navigate a nested folder structure using Globbing
Exercise: Navigate a nested folder structure using Globbing
For this Globbing Exercise, imagine we are running a Company, and we urgently need to provide documents for a court hearing.

Currently, its march.

Take a look at the Folder- File-Structure

How are the Folder and Files named?

Can we use this somehow?

We need to provide all Excel- and PDF-Files for January and February from all departments:

How can we do this?

Can we use Globbing?

Copy those files in a folder named Export



Tipps:
You can use custom ranges; this may help you with selecting the
proper months. For example,[0-4] would match one character of the following: 0, 1, 2, 3, 4

You can combine custom ranges with wildcards,
for example:A [0-4] *
The filename needs to start With an "A", followed by a 0, 1, 2, 3, 4,
and then followed by zero to unlimited characters

You can combine multiple patterns into a singlecp command:
cp [pattern1] [pattern2] [dest]
cp */**/*.jpg */**/*.dng folder


