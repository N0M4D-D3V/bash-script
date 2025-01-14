# <!> USAGE
#
# 1. To test only combinations of a specific length, use: 
#    $ python script.py --specific-length 12
# 2. To test all combinations up to a certain length, use:
#    $ python script.py --max-length 5
# 3. The script defaults to testing all possible combinations 
#    of any length if no specific arguments are provided.  
#
# <>-< 1.0.0 >-<>
# <>-< N0M4D >-<>


import subprocess
from itertools import product
import argparse
import time

# Specify the file paths
keystore_file = "example.jks"
passwords_file = "dictionary.txt"

def test_password(keystore_file, password):
    """Test a password with the keytool command."""
    try:
        # Run the keytool command
        result = subprocess.run(
            ["keytool", "-list", "-v", "-keystore", keystore_file],
            input=password + "\n",
            text=True,
            capture_output=True
        )

        # Log output for debugging
        print(f"Testing password: {password}")
        print(f"STDOUT: {result.stdout}")
        print(f"STDERR: {result.stderr}")

        # Check if the password was successful
        if "Keystore type:" in result.stdout or "Your keystore contains" in result.stdout:
            return True
    except Exception as e:
        print(f"Error testing password: {e}")
    return False

def generate_combinations(dictionary, specific_length=None):
    """Generate combinations of words from the dictionary to form passwords of a specific character length."""
    if specific_length:
        for combination in product(dictionary, repeat=specific_length):
            password = ''.join(combination)
            if len(password) == specific_length:
                yield password
    else:
        length = 1
        while True:
            for combination in product(dictionary, repeat=length):
                password = ''.join(combination)
                yield password
            length += 1

def main():
    parser = argparse.ArgumentParser(description="Test passwords for a JKS file.")
    parser.add_argument("--specific-length", type=int, default=None, help="Specify the exact character length of password combinations to test.")
    args = parser.parse_args()

    start_time = time.time()  # Start timer

    try:
        with open(passwords_file, "r") as file:
            dictionary = [word.strip() for word in file.readlines()]

        attempt_count = 0
        if args.specific_length:
            print(f"Testing passwords with specific length: {args.specific_length}")
            for password in generate_combinations(dictionary, specific_length=args.specific_length):
                attempt_count += 1
                print(f"Attempt {attempt_count}: Testing password '{password}'")
                if test_password(keystore_file, password):
                    print(f"Success! The password is: {password}")
                    break
        else:
            print("Testing passwords with no specific length.")
            for password in generate_combinations(dictionary):
                attempt_count += 1
                print(f"Attempt {attempt_count}: Testing password '{password}'")
                if test_password(keystore_file, password):
                    print(f"Success! The password is: {password}")
                    break

        end_time = time.time()  # End timer
        elapsed_time = end_time - start_time
        print(f"Script execution completed in {elapsed_time:.2f} seconds.")

        print("No valid password found.")
    except FileNotFoundError:
        print(f"Error: {passwords_file} not found.")
    except Exception as e:
        print(f"An error occurred: {e}")

if __name__ == "__main__":
    main()
