How to use the code:
Open the python files in PyCharm or IDLE

ideaSymmetric.py:
	Run the program
	When prompted "Enter message to encrypt:", 
		enter a string of text of size 64-bits or less (8 characters)
	When prompted "Enter key:",
		enter a string of text of size 128-bits (16 characters)
	Ciphertext will be shown in hex (16 characters)
	Plaintext will be shown exactly as typed

elgamalAsymmetric.py:
	Run the program
	When prompted "Enter message to encrypt:",
		enter a string of text of any size
	Ciphertext will be shown as a list of integers (each character from the message entered corresponds to one of the items in the list)
	Plaintext will be shown exacly as typed

whirlpoolHash.py:
	1.
	Install Whirlpool library from the command line
		Type:
			pip install Whirlpool
		If there is error (Microsoft Visual C++ 14.0 is required) or similar when installing,
			Go to Visual Studio Installer
			Click "Modify"
			Under Desktop & Mobile:
				Check "Desktop development with C++"
		Try installing Whirlpool library again
	2.
	Run the program
	When prompted "Enter the message to hash:",
		enter a string of text of any size
	Hash value will be shown in hex (128 characters)

main.py:
	Make sure Whirlpool library is installed (refer to step 1 for whirlpoolHash.py above)
	Run the program
	When prompted "Enter message:",
		enter a string of text of size 64-bits or less (8 characters)
	Hash value will be shown in hex (128 characters)
	Digital signature will be shown as a list of integers (each character from the hash value calculated corresponds to one of the items in the list)
	When prompted "Enter key for IDEA:",
		enter a string of text of size 128-bits (16 characters)
	IDEA encrypted message will be shown in hex (16 characters)
	encrypted IDEA key will be shown as a list of integers (each character from the key entered corresponds to one of the items in the list)
	decrypted IDEA key will be shown as entered
	decrypted message will be shown as entered
	decrypted digital signature will be shown in hex (128 characters) (hash value calculated above)
	hash value of the message will be shown in hex (128 characters)
	A message will be shown to tell if the message has been altered (integrity check using the two hash values)