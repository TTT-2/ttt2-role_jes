L = LANG.GetLanguageTableReference("deutsch")

-- GENERAL ROLE LANGUAGE STRINGS
L[JESTER.name] = "Narr"
L[JESTER.defaultTeam] = "TEAM Narren"
L["hilite_win_" .. JESTER.defaultTeam] = "THE JESTER WON"
L["win_" .. JESTER.defaultTeam] = "Der Narr hat gewonnen!"
L["info_popup_" .. JESTER.name] = [[Du bist DER NARR! Stifte Unruhe und geh drauf!]]
L["body_found_" .. JESTER.abbr] = "Er war ein Narr..."
L["search_role_" .. JESTER.abbr] = "Diese Person war ein Narr!"
L["ev_win_" .. JESTER.defaultTeam] = "Der trottelige Narr hat die Runde gewonnen!"
L["target_" .. JESTER.name] = "Narr"
L["ttt2_desc_" .. JESTER.name] = [[Der Narr ist für alle Verräter (und Serienkiller) sichtbar, aber nicht für Unschuldige oder andere "normale" Rollen (außer spezielle Varräter-Rollen oder den Hellseher).
Der Narr kann keinen Schaden anrichten und sich auch nicht selbst umbringen. Doch wenn er stirbt, GEWINNT er allein. Also töte NICHT den Narr!]]

-- OTHER ROLE LANGUAGE STRINGS
L["ttt2_role_jester_killed_by_player"] = "{nick} hat den Narr getötet!"
L["ttt2_role_jester_killer_info"] = "Du bist gestorben, da du den Narr getötet hast!"
L["ttt2_role_jester_info_no_kill"] = "Töte nicht den Narr!"
L["ttt2_role_jester_info_no_jester"] = "Es gibt diese Runde keinen Narren!"
L["ttt2_role_jester_info_jester_single"] = "'{playername}' ist der Narr!"
L["ttt2_role_jester_info_jester_multiple"] = "'{playernames}' sind die Narren!"

-- WINSTATE LANGS
L["ttt2_role_jester_winstate_0"] = "Zufällige Narr-Gewinnbedingung aktiv."
L["ttt2_role_jester_winstate_1"] = "Narr-Gewinnbedingung 1: Du gewinnst, wenn du getötet wirst."
L["ttt2_role_jester_winstate_2"] = "Narr-Gewinnbedingung 2: Du wirst mit einer gegenteiligen Rolle deines Mörders wiederbelebt."
L["ttt2_role_jester_winstate_3"] = "Narr-Gewinnbedingung 3: Du wirst mit einer gegenteiligen Rolle deines Mörders wiederbelebt nachdem er gestorben ist."
L["ttt2_role_jester_winstate_4"] = "Narr-Gewinnbedingung 4: Du wirst mit der Rolle deines Mörders wiederbelebt nachdem er gestorben ist."
L["ttt2_role_jester_winstate_5"] = "Narr-Gewinnbedingung 5: Du wirst mit der Rolle deines Mörders wiederbelebt und er wird sterben."
L["ttt2_role_jester_winstate_6"] = "Narr-Gewinnbedingung 6: Du wirst mit einer gegenteiligen Rolle deines Mörders wiederbelebt und er wird sterben."
L["ttt2_role_jester_winstate_7"] = "Narr-Gewinnbedingung 7: Du wirst mit der Rolle deines Mörders wiederbelebt und er wird sterben, außer dein Mörder ist Serienmörder oder Verräter."
