local L = LANG.GetLanguageTableReference("fr")

-- GENERAL ROLE LANGUAGE STRINGS
L[JESTER.name] = "Bouffon"
L[JESTER.defaultTeam] = "Team Bouffon"
L["hilite_win_" .. JESTER.defaultTeam] = "LE BOUFFON A GAGNÉ"
L["win_" .. JESTER.defaultTeam] = "Le Bouffon a gagné!"
L["info_popup_" .. JESTER.name] = [[Vous êtes le Bouffon ! Faites du grabuge et laissez-les vous tuer!]]
L["body_found_" .. JESTER.abbr] = "C'était un Bouffon!"
L["search_role_" .. JESTER.abbr] = "Cette personne était un Bouffon!"
L["ev_win_" .. JESTER.defaultTeam] = "Le Bouffon loufoque a gagné la manche!"
L["target_" .. JESTER.name] = "Bouffon"
L["ttt2_desc_" .. JESTER.name] = [[Le Bouffon est visible pour tout les traître, mais pas pour les innocents ou  les autres rôles "normaux"  (à l'exception des rôles de traîtres personnalisé ou du Clairvoyant).
Le bouffon ne peut pas faire de dégâts ni se suicider. Mais s'il meurt, il GAGNERA. Alors ne tuez pas le Bouffon!]]

-- OTHER ROLE LANGUAGE STRINGS
L["ttt2_role_jester_killed_by_player"] = "{nick} a tué le Bouffon!"
L["ttt2_role_jester_killer_info"] = "Vous avez été tué, parce que vous avez tué le Bouffon!"
L["ttt2_role_jester_info_no_kill"] = "Ne tuez pas le Bouffon!"
L["ttt2_role_jester_info_no_jester"] = "Il n'y a pas de Bouffon dans cette manche!"
L["ttt2_role_jester_info_jester_single"] = "'{playername}' est le Bouffon!"
L["ttt2_role_jester_info_jester_multiple"] = "'{playernames}' sont les Bouffons!"

-- WINSTATE LANGS
L["ttt2_role_jester_winstate_0"] = "Conditions de victoire aléatoire du Bouffon active."
L["ttt2_role_jester_winstate_1"] = "Condition de victoire du Bouffon 1: Vous gagnerez si vous êtes tué."
L["ttt2_role_jester_winstate_2"] = "Condition de victoire du Bouffon 2: Vous allez réapparaître avec le rôle opposé de votre tueur."
L["ttt2_role_jester_winstate_3"] = "Condition de victoire du Bouffon 3: Vous réapparaîtrez avec le rôle opposé de votre tueur après sa mort."
L["ttt2_role_jester_winstate_4"] = "Condition de victoire du Bouffon 4: Vous réapparaîtrez avec le rôle de votre tueur après sa mort."
L["ttt2_role_jester_winstate_5"] = "Condition de victoire du Bouffon 5: Vous allez réapparaître avec le rôle de votre tueur et votre tueur va mourir."
L["ttt2_role_jester_winstate_6"] = "Condition de victoire du Bouffon 6: Vous allez renaître avec le rôle opposé de votre tueur et votre tueur va mourir."
L["ttt2_role_jester_winstate_7"] = "Condition de victoire du Bouffon 7: Vous allez renaître avec le rôle de votre tueur et votre tueur va mourir, sauf si votre tueur est un tueur en série ou un traître."
