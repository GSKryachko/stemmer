cat test_words.txt | while read -r line; do ./stemmer.sh "$line"; done > stems.txt
diff stems.txt answers.txt
