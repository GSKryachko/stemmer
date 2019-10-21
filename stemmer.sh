#!/bin/bash
#convert input word to lowercase, replace ё with e
word=$(echo $1  | sed -e 's/\(.*\)/\L\1/' | sed -s 's/ё/е/g');
vowel='[аеиоуыэюя]';
consonant='[^аеиоуыэюя]';
RV=$(echo $word | sed -r "s/^$consonant*.(.*)/\1/");
R1=$(echo $word | sed -r "s/^$consonant*$vowel*$consonant(.*)/\1/");
R2=$(echo $R1 | sed -r "s/^$consonant*$vowel*$consonant(.*)/\1/");

perfective_gerund="(([ая](в|вши|вшись))|(ив|ивши|ившись|ыв|ывши|ывшись))$"
perfective_gerund_replacer="(в|вши|вшись|ив|ивши|ившись|ыв|ывши|ывшись)$"
reflexive="(ся|сь)$"
adjective="(ее|ие|ые|ое|ими|ыми|ей|ий|ый|ой|ем|им|ым|ом|его|ого|ему|ому|их|ых|ую|юю|ая|яя|ою|ею)$"
participle="(([ая](ем|нн|вш|ющ|щ))|(ивш|ывш|ующ))$"
participle_replacer="(ем|нн|вш|ющ|щ|ивш|ывш|ующ)$"
verb="(([ая](ла|на|ете|йте|ли|й|л|ем|н|ло|но|ет|ют|ны|ть|ешь|нно))|(ила|ыла|ена|ейте|уйте|ите|или|ыли|ей|уй|ил|ыл|им|ым|ен|ило|ыло|ено|ят|ует|уют|ит|ыт|ены|ить|ыть|ишь|ую|ю))$"
verb_replacer="(ла|на|ете|йте|ли|й|л|ем|н|ло|но|ет|ют|ны|ть|ешь|нно|ила|ыла|ена|ейте|уйте|ите|или|ыли|ей|уй|ил|ыл|им|ым|ен|ило|ыло|ено|ят|ует|уют|ит|ыт|ены|ить|ыть|ишь|ую|ю)$"
noun="(а|ев|ов|ие|ье|е|иями|ями|ами|еи|ии|и|ией|ей|ой|ий|й|иям|ям|ием|ем|ам|ом|о|у|ах|иях|ях|ы|ь|ию|ью|ю|ия|ья|я)$"
suprelative="(ейш|ейше)$"
derivational="(ост|ость)$"

if [[ "$word" =~ $perfective_gerund ]]; then
	step_1=$(echo $word | sed -r "s/$perfective_gerund_replacer//")
elif [[ "$word" =~ $reflexive ]]; then
	step_1=$(echo $word | sed -r "s/$reflexive//")
#adjectival is defined as adjective | (participle + adjective)
elif [[ "$word" =~ $adjective ]]; then
	step_1=$(echo $word | sed -r "s/$adjective//")
	if [[ "$word" =~ $participle ]]; then
		step_1=$(echo $step_1 | sed -r "s/$participle_replacer//")
	fi;
elif [[ "$word" =~ $verb ]]; then	
	step_1=$(echo $word | sed -r "s/$verb_replacer//")
elif [[ "$word" =~ $noun ]]; then
	step_1=$(echo $word | sed -r "s/$noun//")
else
	step_1=$word
fi;

echo $step_1
