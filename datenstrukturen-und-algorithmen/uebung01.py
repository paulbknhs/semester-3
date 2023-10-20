def algorithm_1(vector_1:list[int], vector_2:list[int]) -> int:
    n = len(vector_1)
    m = len(vector_2)
    if n != m:
        return None
    result = 0
    for i in range(n):
        result += vector_1[i] * vector_2[i]
    return result


def algorithm_2(input_list:list[int]) -> int:
    n = len(input_list)
    max = input_list[0]
    for i in range(n):
        list_sum = 0
        for j in range(i, n):
            list_sum += input_list[j]
            if list_sum > max:
                max = list_sum
    return max