import os
import shutil
import sys

def get_unique_filename(directory, filename):
    name, ext = os.path.splitext(filename)
    counter = 1
    new_filename = filename
    while os.path.exists(os.path.join(directory, new_filename)):
        new_filename = f"{name}_{counter}{ext}"
        counter += 1
    return new_filename

def remove_empty_dirs(root_dir):
    # 递归删除所有空文件夹
    for dirpath, dirnames, filenames in os.walk(root_dir, topdown=False):
        if dirpath == root_dir:
            continue
        if not os.listdir(dirpath):
            os.rmdir(dirpath)

def move_files_recursively_to_current_folder(target_dir):
    current_dir = os.path.abspath(target_dir)
    for root, dirs, files in os.walk(current_dir):
        if root == current_dir:
            continue
        for file in files:
            src_path = os.path.join(root, file)
            unique_name = get_unique_filename(current_dir, file)
            dest_path = os.path.join(current_dir, unique_name)
            shutil.move(src_path, dest_path)
    # 移动完后删除所有空子文件夹
    remove_empty_dirs(current_dir)
    print("所有下级文件夹中的文件已递归移动到当前文件夹，且同名文件已自动重命名。所有空子文件夹已删除。")

if __name__ == "__main__":
    if len(sys.argv) > 1:
        folder = sys.argv[1]
    else:
        folder = os.path.dirname(os.path.abspath(__file__))
    move_files_recursively_to_current_folder(folder) 