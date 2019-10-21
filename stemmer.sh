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
noun="(а|ев|ов|ие|ье|е|иями|ями|ами|еи|ии|ией|ей|ой|ий|й|иям|ям|ием|ем|ам|ом|о|у|ах|иях|ях|ы|ь|ию|ью|ю|ия|ья|я)$"
suprelative="(ейш|ейше)$"
derivational="(ост|ость)$"

if [[ "$RV" =~ $perfective_gerund ]]; then
	step_1=$(echo $word | sed -r "s/$perfective_gerund_replacer//")
else
	if [[ "$RV" =~ $reflexive ]]; then
		without_reflexive=$(echo $word | sed -r "s/$reflexive//")
		RV_without_reflexive=$(echo $RV | sed -r "s/$reflexive//")
	else
		without_reflexive=$word
		RV_without_reflexive=$(echo $RV | sed -r "s/$reflexive//")
	fi;
	#adjectival is defined as adjective | (participle + adjective)
	if [[ "$RV_without_reflexive" =~ $adjective ]]; then
		step_1=$(echo $without_reflexive | sed -r "s/$adjective//")
		if [[ "$step_1" =~ $participle ]]; then
			step_1=$(echo $step_1 | sed -r "s/$participle_replacer//")
		fi;
	elif [[ "$RV_without_reflexive" =~ $verb ]]; then	
		step_1=$(echo $without_reflexive | sed -r "s/$verb_replacer//")
	elif [[ "$RV_without_reflexive" =~ $noun ]]; then
		step_1=$(echo $without_reflexive | sed -r "s/$noun//")
	else
		step_1=$without_reflexive
	fi;
fi;

# echo $step_1

step_2=$(echo $step_1 | sed -r "s/и$//")

# echo $step_2

if [[ "$R2" =~ $derivational ]]; then
	step_3=$(echo $step_2 | sed -r "s/$derivational//")
else
	step_3=$step_2
fi;
# echo $step_3

if [[ "$step_3" =~ ь$ ]]; then
	step_4=$(echo $step_3 | sed -r "s/ь$//")
else
	step_4=$(echo $step_3 | sed -r "s/$suprelative//" | sed -r "s/нн$//" )
fi;

echo $step_4