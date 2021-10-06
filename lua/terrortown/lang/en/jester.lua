L = LANG.GetLanguageTableReference("en")

-- GENERAL ROLE LANGUAGE STRINGS
L[roles.JESTER.name] = "Jester"
L[roles.JESTER.defaultTeam] = "Team Jester"
L["hilite_win_" .. roles.JESTER.defaultTeam] = "TEAM JESTER WON"
L["win_" .. roles.JESTER.defaultTeam] = "The Jester has won!"
L["info_popup_" .. roles.JESTER.name] = [[You are the Jester! Make trouble and let 'em kill you!]]
L["body_found_" .. roles.JESTER.abbr] = "They were a Jester!"
L["search_role_" .. roles.JESTER.abbr] = "This person was a Jester!"
L["ev_win_" .. roles.JESTER.defaultTeam] = "The goofy Jester won the round!"
L["target_" .. roles.JESTER.name] = "Jester"
L["ttt2_desc_" .. roles.JESTER.name] = [[The Jester is visible for any traitor, but not for innocents or other "normal" roles (except custom traitor roles or the Clairvoyant).
The Jester can't deal any damage or kill himself. But if he dies, he will WIN. So don't kill the Jester!]]

-- OTHER ROLE LANGUAGE STRINGS
L["ttt2_role_jester_info_no_kill"] = "Don't kill the Jester!"
L["ttt2_role_jester_info_no_jester"] = "There is no Jester in this round!"
L["ttt2_role_jester_info_jester_single"] = "'{playername}' is the Jester!"
L["ttt2_role_jester_info_jester_multiple"] = "'{playernames}' are the Jesters!"

L["title_event_jester_kill"] = "A Jester was killed"
L["desc_event_jester_kill"] = "{jester} the Jester was killed by a triggerhappy {killer} ({role} / {team})."
L["tooltip_jester_kill_score_jester"] = "Jester kill bonus: {score}"
L["jester_kill_score_jester"] = "Jester kill bonus:"
L["tooltip_jester_kill_score_killer"] = "Jester kill penalty: {score}"
L["jester_kill_score_killer"] = "Jester kill penalty:"
