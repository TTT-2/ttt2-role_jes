local L = LANG.GetLanguageTableReference("fr")

-- GENERAL ROLE LANGUAGE STRINGS
L[roles.JESTER.name] = "Bouffon"
L[roles.JESTER.defaultTeam] = "Team Bouffon"
L["hilite_win_" .. roles.JESTER.defaultTeam] = "LE BOUFFON A GAGNÉ"
L["win_" .. roles.JESTER.defaultTeam] = "Le Bouffon a gagné!"
L["info_popup_" .. roles.JESTER.name] = [[Vous êtes le Bouffon ! Faites du grabuge et laissez-les vous tuer!]]
L["body_found_" .. roles.JESTER.abbr] = "C'était un Bouffon!"
L["search_role_" .. roles.JESTER.abbr] = "Cette personne était un Bouffon!"
L["ev_win_" .. roles.JESTER.defaultTeam] = "Le Bouffon loufoque a gagné la manche!"
L["target_" .. roles.JESTER.name] = "Bouffon"
L["ttt2_desc_" .. roles.JESTER.name] = [[Le Bouffon est visible pour tout les traître, mais pas pour les innocents ou  les autres rôles "normaux"  (à l'exception des rôles de traîtres personnalisé ou du Clairvoyant).
Le bouffon ne peut pas faire de dégâts ni se suicider. Mais s'il meurt, il GAGNERA. Alors ne tuez pas le Bouffon!]]

-- OTHER ROLE LANGUAGE STRINGS
L["ttt2_role_jester_info_no_kill"] = "Ne tuez pas le Bouffon!"
L["ttt2_role_jester_info_no_jester"] = "Il n'y a pas de Bouffon dans cette manche!"
L["ttt2_role_jester_info_jester_single"] = "'{playername}' est le Bouffon!"
L["ttt2_role_jester_info_jester_multiple"] = "'{playernames}' sont les Bouffons!"

--L["title_event_jester_kill"] = "A Jester was killed"
--L["desc_event_jester_kill"] = "{jester} the Jester was killed by a triggerhappy {killer} ({role} / {team})."
--L["tooltip_jester_kill_score_jester"] = "Jester kill bonus: {score}"
--L["jester_kill_score_jester"] = "Jester kill bonus:"
--L["tooltip_jester_kill_score_killer"] = "Jester kill penalty: {score}"
--L["jester_kill_score_killer"] = "Jester kill penalty:"

--L["label_jes_announce"] = "Announce if a Jester is in the round"
--L["label_jes_improvised"] = "Jester can push other players"
--L["label_jes_carry"] = "Jester can pickup entities with the magneto stick"
--L["label_jes_ignitedmg"] = "Jester receives fire damage"
--L["label_jes_explosiondmg"] = "Jester receives explosion damage"
--L["label_jes_exppose_to_all_evils"] = "Exposes their role to all evil roles"
