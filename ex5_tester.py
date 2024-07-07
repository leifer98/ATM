
def generate_diff_diff_series(a0, d1, d, n_terms):
    series = []
    current_term = a0
    current_difference = d1
    
    for _ in range(n_terms):
        series.append(current_term)
        current_term += current_difference
        current_difference += d
    
    return series

def generate_diff_geo_series(first_term, current_diff ,common_ratio, num_terms):
    # Initialize the series list with the first term
    series = [first_term]
    
    # Initialize the first difference
    current_difference = current_diff  # Start with a difference of 1
    
    for i in range(1, num_terms):
        # Calculate the next term in the series
        next_term = series[-1] + current_difference
        # Append the next term to the series
        series.append(next_term)
        # Update the difference for the next iteration
        current_difference *= common_ratio
    
    return series

def generate_quot_arith_series(first_term, initial_quotient, common_difference, num_terms):
    # Initialize the series list with the first term
    series = [first_term]
    
    # Initialize the first quotient
    current_quotient = initial_quotient
    
    for i in range(1, num_terms):
        # Calculate the next term in the series
        next_term = series[-1] * current_quotient
        # Append the next term to the series
        series.append(next_term)
        # Update the quotient for the next iteration
        current_quotient += common_difference
    
    return series

def generate_quot_geo_series(first_term, initial_quotient, common_ratio, num_terms):
    # Initialize the series list with the first term
    series = [first_term]
    
    # Initialize the first quotient
    current_quotient = initial_quotient
    
    for i in range(1, num_terms):
        # Calculate the next term in the series
        next_term = series[-1] * current_quotient
        # Append the next term to the series
        series.append(next_term)
        # Update the quotient for the next iteration
        current_quotient *= common_ratio
    
    return series

# Example usage:
a0 = 3         # Initial term of the series
d1 = 2         # Initial term of the difference series
d = 2           # Common difference of the difference series
n_terms = 7    # Number of terms to generate

series = generate_quot_geo_series(a0, d1, d, n_terms)
print("Generated series:", series)