@echo off
title Le Donjon Maudit - Edition Ultime GitHub
color 0A
cls

:menu
cls
echo ===================================================
echo            LE DONJON MAUDIT - EDITION ULTIME
echo ===================================================
echo.
echo  1. Commencer l'aventure
echo  2. Quitter le jeu
echo.
echo ===================================================
set /p choix="Votre choix (1-2) : "

if "%choix%"=="1" goto choisir_classe
if "%choix%"=="2" exit
goto menu

:choisir_classe
cls
echo ===================================================
echo               CHOISISSEZ VOTRE CLASSE
echo ===================================================
echo.
echo 1. GUERRIER : 25 PV ^| Epee lourde (-5 degats) ^| 2 Potions
echo    [Robuste et puissant, ideal pour debuter]
echo.
echo 2. MAGE     : 16 PV ^| Sort de Boule de Feu (-7 degats) ^| 4 Potions
echo    [Fragile mais inflige d'immenses degats magiques]
echo.
echo 3. VOLEUR   : 18 PV ^| Dague rapide (-3 degats) ^| 3 Potions
echo    [Bonus : Ses esquives reussissent beaucoup plus souvent !]
echo.
set /p classe_choix="Votre choix (1-3) : "

if "%classe_choix%"=="1" (
    set "classe=GUERRIER"
    set "player_hp=25"
    set "degats=5"
    set "potions=2"
    goto start_game
)
if "%classe_choix%"=="2" (
    set "classe=MAGE"
    set "player_hp=16"
    set "degats=7"
    set "potions=4"
    goto start_game
)
if "%classe_choix%"=="3" (
    set "classe=VOLEUR"
    set "player_hp=18"
    set "degats=3"
    set "potions=3"
    goto start_game
)
goto choisir_classe

:start_game
set "has_key=0"
set "dragon_hp=25"
goto intro

:intro
cls
echo ===================================================
echo                    L'ENTREE
echo ===================================================
echo Les lourdes portes de pierre du Donjon Maudit grincent 
echo derriere vous et se referment dans un fracas terrifiant. 
echo Vous etes pris au piege. 
echo.
echo L'air est lourd, charge de poussiere et d'une odeur de 
echo soufre. Un message est grave dans le sang sur le mur :
echo "Le Dragon de Feu garde la seule sortie. Trouve la cle 
echo antique cachee dans les ombres de la bibliotheque, ou 
echo ton squelette rejoindra les autres."
echo.
echo Classe : %classe% ^| Sante : %player_hp% PV ^| Potions : %potions%
echo.
echo Que voulez-vous faire ?
echo 1. Allumer une torche et s'enfoncer dans le Couloir Principal
echo 2. S'effondrer en larmes et abandonner (Fuir)
echo.
set /p choix="Action : "
if "%choix%"=="1" goto couloir
if "%choix%"=="2" goto fin_lache
goto intro


:couloir
cls
echo ===================================================
echo               LE COULOIR PRINCIPAL
echo ===================================================
echo Le couloir se separe en deux directions. Une odeur de soufre
echo vient du Nord. Un silence de mort plane a l'Est.
echo.
echo Classe : %classe% ^| Sante : %player_hp% PV ^| Potions : %potions%
echo.
echo 1. Aller au Nord (Porte en fer)
echo 2. Aller a l'Est (Bibliotheque poussiereuse)
echo 3. Revenir a l'entree
echo.
set /p choix="Action : "
if "%choix%"=="1" goto porte_dragon
if "%choix%"=="2" goto bibliotheque
if "%choix%"=="3" goto intro
goto couloir

:bibliotheque
cls
echo ===================================================
echo                LA BIBLIOTHEQUE
echo ===================================================
if "%has_key%"=="1" (
    echo La piece est vide. Vous avez deja fouille le coffre cache.
) else (
    echo Vous fouillez les vieux grimoires. Derriere une fausse pile
    echo de livres, vous decouvrez un coffre scintillant !
    echo.
    echo [!] Vous avez trouve la CLE DU DRAGON !
    set "has_key=1"
)
echo.
echo 1. Retourner au Couloir Principal
echo.
set /p choix="Action : "
if "%choix%"=="1" goto couloir
goto bibliotheque

:porte_dragon
cls
echo ===================================================
echo               LA PORTE DU DRAGON
echo ===================================================
echo Vous etes face a une immense porte blindee.
echo.
if "%has_key%"=="1" (
    echo Votre cle se met a briller. La porte s'ouvre lentement...
    echo.
    echo 1. Entrer dans l'Arene du Dragon
    echo 2. Reculer
    echo.
    set /p choix="Action : "
    if "%choix%"=="1" goto arene
    if "%choix%"=="2" goto couloir
) else (
    echo La porte est verrouillee par une magie ancienne. Il vous
    echo faut une cle pour l'ouvrir.
    echo.
    echo 1. Retourner au couloir
    echo.
    set /p choix="Action : "
    if "%choix%"=="1" goto couloir
)
goto porte_dragon

:arene
cls
echo ===================================================
echo               L'ARENE DU DRAGON
echo ===================================================
echo Un immense Dragon Rouge se dresse devant vous !
echo.
echo [%classe%] Vos PV : %player_hp%  ^|  PV du Dragon : %dragon_hp%  ^|  Potions : %potions%
echo.
echo 1. Attaquer (-%degats% PV au Dragon, -4 PV a vous)
echo 2. Tenter une esquive risquee (Contre-attaque puissante)
echo 3. Boire une potion (+8 PV)
echo.
set /p choix="Action : "

if "%choix%"=="1" (
    set /a dragon_hp=%dragon_hp%-%degats%
    set /a player_hp=%player_hp%-4
    echo Vous frappez le monstre ! (-%degats% PV au Dragon)
    echo Le dragon riposte brutalement ! (-4 PV)
    pause
    goto check_status
)
if "%choix%"=="2" (
    :: Si le joueur est un Voleur, il a 75% de chance de reussir (hasard 0, 1 ou 2 sur 4)
    :: Autrement, 50% de chance (hasard 0 sur 2)
    if "%classe%"=="VOLEUR" (
        set /a hasard=%random% %% 4
        if not "%hasard%"=="3" (goto esquive_reussie) else (goto esquive_echec)
    ) else (
        set /a hasard=%random% %% 2
        if "%hasard%"=="0" (goto esquive_reussie) else (goto esquive_echec)
    )
)
if "%choix%"=="3" (
    if %potions% gtr 0 (
        set /a potions=%potions%-1
        set /a player_hp=%player_hp%+8
        echo Vous buvez une potion magique. Vous recuperez des forces ! (+8 PV)
    ) else (
        echo Plus de potions ! Vous perdez du temps a chercher...
        set /a player_hp=%player_hp%-2
        echo Le dragon en profite pour vous griffer ! (-2 PV)
    )
    pause
    goto check_status
)
goto arene

:esquive_reussie
:: Le contre fait 3 degats de plus que l'attaque normale
set /a contre_degats=%degats%+3
set /a dragon_hp=%dragon_hp%-%contre_degats%
echo Esquive parfaite ! Vous passez sous son aile et frappez ! (-%contre_degats% PV au Dragon)
pause
goto check_status

:esquive_echec
set /a player_hp=%player_hp%-6
echo Echec de l'esquive ! Le dragon anticipe et vous ecrase ! (-6 PV)
pause
goto check_status

:check_status
if %player_hp% leq 0 goto mort
if %dragon_hp% leq 0 goto victoire
goto arene

:mort
cls
echo ===================================================
echo                     GAME OVER
echo ===================================================
echo.
echo Vous avez peri... Essayez une autre classe pour changer de strategie !
echo.
pause
goto menu

:victoire
cls
echo ===================================================
echo                     VICTOIRE !
echo ===================================================
echo.
echo Le Dragon s'effondre. Vous avez gagne en tant que %classe% !
echo Les portes s'ouvrent sur la liberte. Bravo !
echo.
pause
goto menu

:fin_lache
cls
echo Vous fuyez en courant. Le monde se souviendra de votre couardise.
echo Fin de la partie.
pause
exit
