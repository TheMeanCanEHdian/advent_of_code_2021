import copy
import os

def calculate_most_common(values):
    bit_lists = []
    for value in values:
        bit_lists.append([char for char in value])

    grouped_bits_list = []
    for bits in bit_lists[0]:
        grouped_bits_list.append([])

    i = 0
    while i < 12:
        for list in bit_lists:
            for index, bit in enumerate(list):
                grouped_bits_list[index].append(bit)
        i += 1
    
    most_common = ''

    for group in grouped_bits_list:
        zeros = group.count('0')
        ones = group.count('1')

        if zeros > ones:
            most_common += '0'
        else:
            most_common += '1'
    
    return most_common

def calculate_least_common(values):
    bit_lists = []
    for value in values:
        bit_lists.append([char for char in value])

    grouped_bits_list = []
    for bits in bit_lists[0]:
        grouped_bits_list.append([])

    i = 0
    while i < 12:
        for list in bit_lists:
            for index, bit in enumerate(list):
                grouped_bits_list[index].append(bit)
        i += 1
    
    least_common = ''

    for group in grouped_bits_list:
        zeros = group.count('0')
        ones = group.count('1')

        if zeros <= ones:
            least_common += '0'
        else:
            least_common += '1'
    
    return least_common


def main():
    __location__ = os.path.realpath(os.path.join(os.getcwd(), os.path.dirname(__file__)))
    with open(os.path.join(__location__,'input.txt')) as file:
        values = file.readlines()
        values = [value.rstrip() for value in values]

    # Part 1
    most_common = calculate_most_common(values)
    least_common = calculate_least_common(values)

    gamma_rate = f'0b{most_common}'
    epsilon_rate = f'0b{least_common}'

    print(int(gamma_rate, 2) * int(epsilon_rate, 2))

    # Part 2
    oxygen_values = copy.copy(values)
    c02_values = copy.copy(values)

    i = 0
    while i < 12:
        oxygen_values_to_remove = []
        c02_values_to_remove = []

        most_common = calculate_most_common(oxygen_values)
        least_common = calculate_least_common(c02_values)
        
        # Calculate Oxygen
        for value in oxygen_values:
            if value[i] != most_common[i]:
                oxygen_values_to_remove.append(value)
        
        if len(oxygen_values_to_remove) < len(oxygen_values):
            for value_to_remove in oxygen_values_to_remove:
                oxygen_values.remove(value_to_remove)

        # Calculate C02
        for value in c02_values:
            if value[i] != least_common[i]:
                c02_values_to_remove.append(value)
        
        if len(c02_values_to_remove) < len(c02_values):
            for value_to_remove in c02_values_to_remove:
                c02_values.remove(value_to_remove)

        i += 1
    
    # Convert from binary to int and multiply
    print(int(f'0b{oxygen_values[0]}', 2) * int(f'0b{c02_values[0]}', 2))

if __name__ == "__main__":
    main()