L = LANG.GetLanguageTableReference("english")

-- GENERAL ROLE LANGUAGE STRINGS
L[JESTER.name] = "Jester"
L[JESTER.defaultTeam] = "TEAM Jesters"
L["hilite_win_" .. JESTER.defaultTeam] = "THE JESTER WON"
L["win_" .. JESTER.defaultTeam] = "The Jester has won!"
L["info_popup_" .. JESTER.name] = [[You are the JESTER! Make TROUBLE and let 'em kill you!]]
L["body_found_" .. JESTER.abbr] = "They were a Jeste!"
L["search_role_" .. JESTER.abbr] = "This person was a Jester!"
L["ev_win_" .. JESTER.defaultTeam] = "The goofy Jester won the round!"
L["target_" .. JESTER.name] = "Jester"
L["ttt2_desc_" .. JESTER.name] = [[The Jester is visible for any traitor, but not for innocents or other "normal" roles (except custom traitor roles or the Clairvoyant).
The Jester can't deal any damage or kill himself. But if he dies, he will WIN. So don't kill the Jester!]]

-- OTHER ROLE LANGUAGE STRINGS
L["ttt2_role_jester_killed_by_player"] = "{nick} killed the Jester!"
L["ttt2_role_jester_killer_info"] = "You were killed, because you killed the Jester!"
L["ttt2_role_jester_info_no_kill"] = "Don't kill the Jester!"
L["ttt2_role_jester_info_no_jester"] = "There is no Jester in this round!"
L["ttt2_role_jester_info_jester_single"] = "'{player_name}' is the Jester!"
L["ttt2_role_jester_info_jester_multiple"] = "'{player_names}' are the Jesters!"
