local L = LANG.GetLanguageTableReference("es")

-- GENERAL ROLE LANGUAGE STRINGS
L[roles.JESTER.name] = "Jester"
L[roles.JESTER.defaultTeam] = "Team Jesters"
L["hilite_win_" .. roles.JESTER.defaultTeam] = "EL JESTER GANA"
L["win_" .. roles.JESTER.defaultTeam] = "¡El Jester ha ganado!"
L["info_popup_" .. roles.JESTER.name] = [[¡Eres el Jester! ¡Genera problemas  y has que te maten!]]
L["body_found_" .. roles.JESTER.abbr] = "¡Era un Jester!"
L["search_role_" .. roles.JESTER.abbr] = "Esta persona era un Jester."
L["ev_win_" .. roles.JESTER.defaultTeam] = "¡El torpe bufón ha ganado la ronda!"
L["target_" .. roles.JESTER.name] = "Jester"
L["ttt2_desc_" .. roles.JESTER.name] = [[El Jester es visible a los demás traidores, pero no para los inocentes o roles "normales" (Exceptuando roles específicos de traidor y el Clarividente).
El Jester no inflige ningún daño ni puede suicidarse. Si de alguna manera muere, ganará. ¡No le apuntes a la cabeza!]]

-- OTHER ROLE LANGUAGE STRINGS
L["ttt2_role_jester_info_no_kill"] = "¡No mates al Jester!"
L["ttt2_role_jester_info_no_jester"] = "¡No apareció un Jester esta ronda!"
L["ttt2_role_jester_info_jester_single"] = "¡'{playername}' es el Jester!"
L["ttt2_role_jester_info_jester_multiple"] = "¡'{playernames}' son los Jesters!"

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
