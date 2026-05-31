import re
import os
import shutil

def title_to_filename(title):
    # Lowercase the title
    title = title.lower()
    # Remove all punctuation including periods and parentheses
    title = re.sub(r'[\"\'():\.]', '', title)
    # Replace spaces and slashes with hyphens
    title = re.sub(r'[\s/]+', '-', title)
    # Remove any remaining non-alphanumeric or non-hyphen characters
    title = re.sub(r'[^a-z0-9\-]', '', title)
    return title

def create_directory(newpath):
    if not os.path.exists(newpath):
        os.makedirs(newpath)

def create_file(newpath, filename):
    filepath = os.path.join(newpath, filename)
    if not os.path.exists(filepath):
        with open(filepath, "x") as f:
            pass  # Or write initial content if needed

import os

def append_line(file_path: str, line: str) -> None:
    os.makedirs(os.path.dirname(file_path), exist_ok=True)

    # open in append mode and write the line
    with open(file_path, "a", encoding="utf-8") as f:
        f.write(f"{line}\n")

def move_files(source_dir, target_dir):
    file_names = os.listdir(source_dir)
    for file_name in file_names:
        shutil.move(os.path.join(source_dir, file_name), target_dir)

def prepare_resources(section_title, part_title):
    section_directory_path = "./" + title_to_filename(section_title)
    create_directory(section_directory_path)
    part_directory_path = section_directory_path + "/" + title_to_filename(part_title)
    print(part_directory_path)
    create_directory(part_directory_path)
    create_file(part_directory_path, "note.md")
    note_path = os .path.join(part_directory_path, "note.md")
    append_line(note_path, f"## {part_title}")
    move_files("./downloads", part_directory_path)

def create_code_exercise(section_title, part_title):
    section_directory_path = "./" + title_to_filename(section_title)
    create_directory(section_directory_path)
    part_directory_path = section_directory_path + "/" + title_to_filename(part_title)
    # print(part_directory_path)
    create_directory(part_directory_path)

section_title = 'Section 27: Web Project Setup'
# section_title = "quizzes"

part_title = "357. Adding a Port to httpd [CentOS]"
print(f"export PART_TITLE='{part_title}'")

prepare_resources(section_title, part_title)
# create_code_exercise(section_title, part_title)