local L = LANG.GetLanguageTableReference("it")

-- GENERAL ROLE LANGUAGE STRINGS
L[roles.JESTER.name] = "Giullare"
L[roles.JESTER.defaultTeam] = "Team Giullari"
L["hilite_win_" .. roles.JESTER.defaultTeam] = "I GIULLARI HANNO VINTO"
L["win_" .. roles.JESTER.defaultTeam] = "Il Giullare ha vinto!"
L["info_popup_" .. roles.JESTER.name] = [[Sei il Giullare! Fai confusione e fatti uccidere!]]
L["body_found_" .. roles.JESTER.abbr] = "Era un Giullare!"
L["search_role_" .. roles.JESTER.abbr] = "Questa persona era un Giullare!"
L["ev_win_" .. roles.JESTER.defaultTeam] = "Lo stupido Giullare ha vinto il round!"
L["target_" .. roles.JESTER.name] = "Giullare"
L["ttt2_desc_" .. roles.JESTER.name] = [[Il Giullare è visibile per tutti i traditori, ma non per gli innocenti o altri ruoli "normali" (tranne traditori speciali o il Chiaroveggente).
Il Jester non può fare danno o uccidersi. Ma se muore, vince. Quindi non uccidere il Giullare!]]

-- OTHER ROLE LANGUAGE STRINGS
L["ttt2_role_jester_info_no_kill"] = "Non uccidere il Giullare!"
L["ttt2_role_jester_info_no_jester"] = "Non c'è nessun Giullare questo round!"
L["ttt2_role_jester_info_jester_single"] = "'{playername}' è il Giullare!"
L["ttt2_role_jester_info_jester_multiple"] = "'{playernames}' sono i Giullare!"

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
