import numpy as np

np.set_printoptions(linewidth=np.inf)

def generate_repeating_array(rows, cols):
    if rows % 8 != 0:
        raise ValueError("The number of rows must be a multiple of 8.")

    pattern = np.arange(1, 9).reshape(-1, 1)  
    repeating_array = np.tile(pattern, (rows // 8, cols))
    return repeating_array

def matrces_multiplication(matrix, deb_mode=False):
    array_y_transposed = matrix.T
        
    result = np.dot(matrix, array_y_transposed)

    if deb_mode:
        print("Matrix X:")
        print(matrix)
        print("\nMatrix Y (Original):")
        print(matrix)
        print("\nMatrix Y (Transposed):")
        print(array_y_transposed)
        print("\nResult of Matrix Multiplication (X * Y Transposed):")
    print(result, end='\n')

    return result


matrix_8 = generate_repeating_array(8, 8)
matrix_16 = generate_repeating_array(16, 16)
matrix_32 = generate_repeating_array(32, 32)

print("8 x 8 Matrix Multiplication Result:")
result_8 = matrces_multiplication(matrix_8, False)
print("--------------------------------------------------------------------------------")

print("16 x 16 Matrix Multiplication Result:")
result_16 = matrces_multiplication(matrix_16, False)
print("--------------------------------------------------------------------------------")

print("32 x 32 Matrix Multiplication Result:")
result_32 = matrces_multiplication(matrix_32, False)
print("--------------------------------------------------------------------------------")
