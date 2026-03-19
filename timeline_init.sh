#!/bin/bash

set -e

if git rev-parse --is-inside-work-tree > /dev/null 2>&1; then
    echo "Nope: You cannot use this script inside a Git repository!"
    exit 1
fi

mkdir git-history-sim
cd git-history-sim
git init --initial-branch=timeline

git config user.name "Bellhaven Correctional Committee"
git config user.email "bellhaven.facilitee@crossing.com"

git config advice.detachedHead false

echo "Please wait..."

commit() {
    git add -A
    local date="2025-05-05 $2:00:00"
    GIT_COMMITTER_DATE="$date" git commit --allow-empty-message -m "$1" --date="$date" > /dev/null 2>&1
}
mood() {
    echo "MOOD: $2

    INFOS:
    $3" > "$1"
}

mkdir tom_nook_store museum post_office town_hall department_store beach houses

touch museum/.keep
touch museum/blathers
mood museum/blathers 'normal' 'Opening the museum.
He is very happy to add two new items to his collection:
- a statue of a golden monkey that catches nightmares.
- a bronze key that can open any lock.'

touch town_hall/.keep
touch town_hall/isabelle
mood town_hall/isabelle 'normal' 'Opening the town hall.'

touch houses/.keep
touch houses/K.K
mood houses/K.K 'sleeping in his house.'

touch tom_nook_store/.keep
touch tom_nook_store/tom_nook
mood tom_nook_store/tom_nook 'normal' 'Opening his shop.'

touch houses/villager
mood houses/villager 'sleeping in their house.'

touch beach/.keep
touch beach/rudy
mood beach/rudy 'relaxed' '(He slept on the beach last night)'

touch department_store/.keep
touch department_store/bill
mood department_store/bill 'normal' 'Opening the store.'

touch post_office/.keep
touch post_office/pelly
mood post_office/pelly 'cheerful' 'She love her work.'

touch tortimer
mood tortimer 'thinking' 'He is on his private boat, traveling to the island.'

commit "The day begin: It's 10 AM." 10


# 11H
#  
mv tortimer beach/tortimer
mood beach/tortimer 'determined' 'He has arrived on the island.'

mood beach/rudy 'relaxed' 'He helped the old tortimer getting out of his boat.'

mv houses/villager villager
mood villager 'happy' 'He is walking arround.'

mood tom_nook_store/tom_nook 'happy' 'Counting his bells while nobody is here.'

mood houses/K.K 'Still sleeping' 'Probably dreaming about his music show tonight.'

mood museum/blathers 'normal' 'Working.'

mood department_store/bill 'bored'

mood town_hall/isabelle 'normal' 'Waiting for people to enter...'

commit "" 11


# 12h
# 
mv beach/tortimer museum/tortimer
mood museum/tortimer 'thinking' 'Talking with Blathers.'

mood museum/blathers 'stressed' 'He does not like what Tortimer is telling him.'

mv town_hall/isabelle post_office/isabelle
mood post_office/isabelle 'normal' 'Dropping a blue letter to the office'

mood post_office/pelly 'cheerful' 'Gossiping with Isabelle.'

mood houses/K.K 'Still sleeping' 'Dreaming about The Great Flood due to climate change.'

mood beach/rudy 'relaxed' 'Basking on the beach.
(He has absolutely nothing to do.)'

mv villager beach/villager
mood beach/villager 'devious' "Thinking about how they could steal Tortimer's boat."

commit "" 12


# 13H
# 
mv houses/K.K tom_nook_store/K.K
mood tom_nook_store/K.K 'groggy' 'He slept too much, and now he needs to buy stuff for tonight.'

mood tom_nook_store/tom_nook 'happy' 'Thinking about how much mony he can extort K.K.'

mv museum/tortimer town_hall/tortimer
mood town_hall/tortimer 'happy' 'Discussing mortgage with Isabelle.'

mv post_office/isabelle town_hall/isabelle
mood town_hall/isabelle 'bored, a bit upset' 'Pretending that she is interested in the conversation with Tortimer.'

mood museum/blathers 'panicking' 'He must get that letter.'

mv beach/villager department_store/villager
mood department_store/villager 'thinking' 'Thinking about how they could acquire more bells to buy more stuff.'

mood department_store/bill 'happy' 'Really happy to see his favorite customer.'

mood post_office/pelly 'cheerful' 'She love her work.'

commit "" 13


# 14H
# 
mv town_hall/isabelle tom_nook_store/isabelle
mood tom_nook_store/isabelle 'relieve' 'She took a break from the Town Hall.
There is a furniture that she REALLY want.'

mood town_hall/tortimer 'happy' 'He is completely alone in the building.'

mv tom_nook_store/K.K beach/K.K
mood beach/K.K 'chill' 'He like the feeling of the sand between his paws.'

mv beach/rudy rudy
mood rudy 'hurt' 'He is walking away from the beach, he got a sunburn...'

mood museum/blathers 'stressed, thinking' 'Running in circle.'

mv post_office/pelly pelly
mood pelly 'happy' 'Takin a little break from her job.'

mood tom_nook_store/tom_nook 'happy' 'The day is going well.'

mood department_store/bill 'normal' 'Disappointed that the villager did not buy anything.'

mv department_store/villager villager
mood villager 'normal' 'Walking arround.'

commit "" 14


# 15H
# 
mv tom_nook_store/isabelle town_hall/isabelle
mood town_hall/isabelle 'angry' 'The prices of Tom Nook are really too expensive.'

mv museum/blathers blathers
mood blathers 'stressed' 'He is running.'

mv pelly post_office/pelly
mood post_office/pelly 'cheerful' 'Back to work!
She received an anonymous red letter from the mail box.'

mood town_hall/tortimer 'normal'
mood department_store/bill 'bored'

mv rudy houses/rudy
mood houses/rudy 'sad' 'Poor guy...'

mv tom_nook_store/tom_nook tom_nook
mood tom_nook 'relaxed' 'Taking a break.'

commit "" 15


# 16H
mv blathers post_office/blathers
mood post_office/blathers 'thinking' 'Reading the content of the letter.'

mood post_office/pelly 'a bit worried' "She just gave a red letter to Blathers.
He doesn't look to well."

mv beach/K.K museum/K.K
mood museum/K.K 'chill' 'He just wanted to chill in the museum.
He is surprise to find the museum empty.'

mood town_hall/tortimer 'concerned' 'He is hoping that the Post Office received his letter.'

mv tom_nook tom_nook_store/tom_nook
mood tom_nook_store/tom_nook 'happy' 'back in buisness.'

mood town_hall/isabelle 'sleepy'
mood department_store/bill 'super bored'

mood villager 'elated' 'They just catched a super rare insect!'

commit "" 16


#17H
# 
mood post_office/pelly 'normal'

mood town_hall/isabelle 'sleeeping'

mood department_store/bill 'sympathetic' 'He is wondering about giving the gel for free'

mv houses/rudy department_store/rudy
mood houses/rudy 'hopefull' 'Hoping to get a tube of gel to ease the pain.'

mv post_office/blathers museum/blathers
mood museum/blathers 'nervous'

mood museum/K.K 'chill' 'He is thinking about the fact that Blathers should chill out a bit.'

mv villager houses/villager
mood houses/villager 'happy' 'He is putting the insect in his cage.'

mood town_hall/tortimer 'normal' 'He is waiting and looking at his watch.'

mood tom_nook_store/tom_nook 'normal'

commit "" 17


#18H
# 
mood town_hall/tortimer 'impatient' 'He is waiting and looking at his watch.'

mood museum/blathers 'nervous' 'He takes a bronze key from his museum.'

mood houses/villager 'happy' 'Redecorating his house.'

mood department_store/bill 'bored'

mv museum/K.K tom_nook_store/K.K
mood tom_nook_store/K.K 'a bit angry' 'He cannot believe that Tom Nook told him that he could buy his guitare.'

mv department_store/rudy houses/rudy
mood houses/rudy 'happy' 'He is appliying the gel.'

mood post_office/pelly 'a bit tired' 'Waiting for her sister.'

commit "" 18

# 19H
#
mood town_hall/isabelle 'tired' 'She woke up and closed the Town Hall.'

mv town_hall/tortimer tortimer
mood tortimer 'focus' 'He is entering a telephone booth and pickup the phone.'

mv tom_nook_store/K.K K.K
mood K.K 'chill' 'He is enjoying the fresh air outside.'

mood department_store/bill 'happy' 'He is closing his shop.'

mv post_office/pelly houses/pelly
mood houses/pelly 'tired' 'Going home early.
Her sister took her place.'

touch post_office/phyllis
mood post_office/phyllis 'grumpy' 'She hate her job.'

mood museum/blathers 'calming down' 'He is closing the museum.'

mood houses/rudy 'resting' 'He is doing a nap.'

commit "" 19

# 20H
#
mood houses/pelly 'sleeping in her house'

mv town_hall/isabelle tom_nook_store/isabelle
mood tom_nook_store/isabelle 'normal' 'Discussing with Tom Nook to try to see if he can reduce his prices.'

mv museum/blathers tom_nook_store/blathers
mood tom_nook_store/blathers 'looks calm' 'He makes use of the key.'

mood tom_nook_store/tom_nook 'distracted' 'He is having a call while disussing with Isabelle.'

mood tortimer 'calm' 'He is doing a phone call.'

mv K.K houses/K.K
mood houses/K.K 'chill' 'He is grabbing his guitare.'

mv department_store/bill beach/bill
mood beach/bill 'relaxing'

mv houses/villager villager
mood villager 'happy' 'Taking a stroll trough the forest.'

commit "" 20

# 21H
#
mood tom_nook_store/tom_nook 'angry' 'He will not falter!
He will not lower his prices!'

mood tom_nook_store/isabelle 'angry' 'Bickering with Tom Nook about his prices.'

mv tortimer beach/tortimer
mood beach/tortimer 'nervous' 'He is waiting by his boat.'

mv tom_nook_store/blathers museum/blathers
mood museum/blathers 'stressed' 'He is dropping the bronze key in his museum.'

mood villager 'worried' 'They got lost in the forest...'

mv houses/rudy beach/rudy
mood beach/rudy 'happy' "The night is here.
The sun can't burn him anymore"

mood houses/K.K 'chill' 'Practicing the guitare.'

commit "" 21

# 22H
# 
mood tom_nook_store/tom_nook 'tired' 'He won the dispute...
He is closing his shop.'

mv tom_nook_store/isabelle houses/isabelle
mood houses/isabelle 'angry, tired' 'She did not buy anything.'

mood beach/tortimer 'happy' 'He is satisfied with blathers.'

mv museum/blathers beach/blathers
mood beach/blathers 'stressed' 'He gives a bag to Tortimer.'


mood beach/rudy 'happy'

mood villager 'worried' 'They are still lost in the forest.'

commit "" 22

# 23H
#
mv houses/K.K beach/K.K
mood beach/K.K 'chill' 'He is doing his music concert on the beach.'

mood houses/isabelle 'sleeping in her house'

mv beach/tortimer tortimer
mood tortimer 'happy' 'He is leaving the island on his private boat.'

mv beach/blathers houses/blathers


mood houses/blathers 'regretful'


mood beach/rudy 'happy' "Listening to K.K's concert."
mood beach/bill 'happy' "Listening to K.K's concert."

mv villager beach/villager
mood beach/villager 'relieved' 'They found a way out thanks to the music of K.K.'


mv tom_nook_store/tom_nook houses/tom_nook
mood houses/tom_nook 'thinking' 'He wanted to sleep,
but he feel like he has forgotten something in his shop.'

commit "" 23

# 00H
#

rm tortimer

mv beach/rudy houses/rudy
mood houses/rudy 'sleeping in his house.'

mv beach/bill houses/bill
mood houses/bill 'sleeping in his house.'

mv beach/villager houses/villager
mood houses/villager 'sleeping in their house.'

mv beach/K.K houses/K.K
mood houses/K.K 'sleeping in his house.'

mood houses/blathers 'sleeping in his house.'


mv houses/tom_nook tom_nook_store/tom_nook
mood tom_nook_store/tom_nook 'panicking' 'His bell chest is open!
Someone stole all his bells!!!'

mood post_office/phyllis 'grumpy' 'Still working...
stil hating her job.'

git add -A
date="2025-05-06 00:00:00"
GIT_COMMITTER_DATE="$date" git commit --allow-empty-message -m "The day is ending: It's 12 AM." --date="$date" > /dev/null 2>&1

echo "The Git repo was successfully created!"
echo
echo "This repository was assembled by the Bellhaven Committee."
echo "Good luck in your investigation, detective!"
