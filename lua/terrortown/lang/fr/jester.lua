local L = LANG.GetLanguageTableReference("fr")

-- GENERAL ROLE LANGUAGE STRINGS
L[roles.JESTER.name] = "Bouffon"
L[roles.JESTER.defaultTeam] = "Équipe des Bouffons"
L["hilite_win_" .. roles.JESTER.defaultTeam] = "L'ÉQUIPE DES BOUFFONS A GAGNÉ"
L["win_" .. roles.JESTER.defaultTeam] = "Les Bouffons ont gagné !"
L["info_popup_" .. roles.JESTER.name] = [[Vous êtes le Bouffon ! Faites du grabuge et laissez-les vous tuer !]]
L["body_found_" .. roles.JESTER.abbr] = "C'était un Bouffon !"
L["search_role_" .. roles.JESTER.abbr] = "C'était un Bouffon !"
L["ev_win_" .. roles.JESTER.defaultTeam] = "Les Bouffons loufoques ont gagné la partie !"
L["target_" .. roles.JESTER.name] = "Bouffon"
L["ttt2_desc_" .. roles.JESTER.name] = [[Les Bouffons sont visibles pour tous les traîtres, mais pas pour les innocents ou  les autres rôles "normaux"  (à l'exception des rôles de traîtres personnalisé ou du Clairvoyant).
Les bouffons ne peuvent pas se faire de dégâts ni se suicider. Mais s'il meurt, il GAGNERA. Alors ne tuez pas les Bouffons !]]

-- OTHER ROLE LANGUAGE STRINGS
L["ttt2_role_jester_info_no_kill"] = "Ne tuez pas le Bouffon !"
L["ttt2_role_jester_info_no_jester"] = "Il n'y a pas de Bouffon dans cette partie !"
L["ttt2_role_jester_info_jester_single"] = "'{playername}' est un Bouffon !"
L["ttt2_role_jester_info_jester_multiple"] = "'{playernames}' sont des Bouffons !"

L["title_event_jester_kill"] = "Un Bouffon a été tué"
L["desc_event_jester_kill"] = "{jester} le Bouffon a été tué par un terroriste à la gâchette facile {killer} ({role} / {team})."
L["tooltip_jester_kill_score_jester"] = "Bonus de la mort du Bouffon: {score}"
L["jester_kill_score_jester"] = "Jester kill bonus:"
L["tooltip_jester_kill_score_killer"] = "Pénalité du meurtre du Bouffon: {score}"
L["jester_kill_score_killer"] = "Pénalité du meurtre du Bouffon:"

L["label_jes_announce"] = "Annonce si un bouffon est dans la partie"
L["label_jes_improvised"] = "Le bouffon peut pousser les autres joueurs"
L["label_jes_carry"] = "Le bouffon peut porter des entités avec le magnéto-stick"
L["label_jes_ignitedmg"] = "Le bouffon peut subir des dégâts du feu"
L["label_jes_explosiondmg"] = "Le bouffon peut subir des dégâts des explosions"
L["label_jes_exppose_to_all_evils"] = "Affiche les bouffons à tous les rôles de traître"
