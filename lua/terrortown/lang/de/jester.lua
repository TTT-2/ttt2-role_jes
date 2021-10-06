L = LANG.GetLanguageTableReference("de")

-- GENERAL ROLE LANGUAGE STRINGS
L[roles.JESTER.name] = "Narr"
L[roles.JESTER.defaultTeam] = "Team Narren"
L["hilite_win_" .. roles.JESTER.defaultTeam] = "TEAM NARR GEWANN"
L["win_" .. roles.JESTER.defaultTeam] = "Der Narr hat gewonnen!"
L["info_popup_" .. roles.JESTER.name] = [[Du bist der Narr! Stifte Unruhe und lass dich töten!]]
L["body_found_" .. roles.JESTER.abbr] = "Er war ein Narr..."
L["search_role_" .. roles.JESTER.abbr] = "Diese Person war ein Narr!"
L["ev_win_" .. roles.JESTER.defaultTeam] = "Der trottelige Narr hat die Runde gewonnen!"
L["target_" .. roles.JESTER.name] = "Narr"
L["ttt2_desc_" .. roles.JESTER.name] = [[Der Narr ist für alle Verräter (und Serienkiller) sichtbar, aber nicht für Unschuldige oder andere "normale" Rollen (außer spezielle Varräter-Rollen oder den Hellseher).
Der Narr kann keinen Schaden anrichten und sich auch nicht selbst umbringen. Doch wenn er stirbt, GEWINNT er allein. Also töte NICHT den Narr!]]

-- OTHER ROLE LANGUAGE STRINGS
L["ttt2_role_jester_info_no_kill"] = "Töte nicht den Narr!"
L["ttt2_role_jester_info_no_jester"] = "Es gibt diese Runde keinen Narren!"
L["ttt2_role_jester_info_jester_single"] = "'{playername}' ist der Narr!"
L["ttt2_role_jester_info_jester_multiple"] = "'{playernames}' sind die Narren!"

L["title_event_jester_kill"] = "Ein Narr wurde getötet"
L["desc_event_jester_kill"] = "{jester} der Narr wurde von einem schießwütigem {killer} ({role} / {team}) ermordet."
L["tooltip_jester_kill_score_jester"] = "Narrenmordbonus: {score}"
L["jester_kill_score_jester"] = "Narrenmordbonus:"
L["tooltip_jester_kill_score_killer"] = "Narrenmordstrafe: {score}"
L["jester_kill_score_killer"] = "Narrenmordstrafe:"
