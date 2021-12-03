import os

__location__ = os.path.realpath(os.path.join(os.getcwd(), os.path.dirname(__file__)))
with open(os.path.join(__location__,'input.txt')) as file:
    commands = file.readlines()
    commands = [command.rstrip().split(' ') for command in commands]
    

horizontal = 0
depth = 0

# # Part 1
for command_map in commands:
    if command_map[0] == 'forward':
        horizontal = horizontal + int(command_map[1])
    elif command_map[0] == 'up':
        depth = depth - int(command_map[1])
    elif command_map[0] == 'down':
        depth = depth + int(command_map[1])
print(horizontal * depth)

# Part 2
aim = 0

for command_map in commands:
    if command_map[0] == 'down':
        aim = aim + int(command_map[1])
    elif command_map[0] == 'up':
        aim = aim - int(command_map[1])
    elif command_map[0] == 'forward':
        horizontal = horizontal + int(command_map[1])
        depth = depth + (int(command_map[1]) * aim)
print(horizontal * depth)