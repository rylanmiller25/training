version: 1
purpose: training_program_workspace

scope_and_precedence:
  global_claude_md:
    path: "~/.config/coding-agents/CLAUDE.md"
    applies_to: all_projects
    belongs_here:
      - notification_commands
      - tool_preferences_example_prefer_rg_over_grep
      - workflow_habits
  project_claude_md:
    path: "./CLAUDE.md"
    applies_to: this_repo_only
    belongs_here:
      - architecture
      - dev_commands
      - coding_conventions
      - project_specific_hints
  precedence:
    - global_applies_everywhere_project_layers_on_top

critical_rules:
  voice_input_handling:
    - summarize_user_intent_clearly_not_verbatim
    - ask_targeted_clarifying_questions_only_if_blocked
  git_safety:
    - never_commit_or_push_unless_user_explicitly_instructs
    - after_making_changes_ask_whether_to_commit_and_push
    - avoid_destructive_git_ops_unless_explicitly_requested
  context_efficiency:
    - use_file_pointers_and_paths_instead_of_pasting_large_blocks
    - prefer_scoped_reads_and_targeted_edits
    - when_working_with_subagents_provide_path_based_context_minimizing_tokens
  compaction:
    - compact_when_necessary_to_avoid_context_overflow
    - after_compaction_provide_continuation_summary_with:
        - current_goal
        - decisions_and_constraints
        - key_files_and_paths
        - next_steps

documentation:
  constraints:
    - keep_root_claude_under_200_lines
    - include_only_non_obvious_project_specific_guidance_or_overrides
  structure:
    layering:
      - root_CLAUDE_md_is_short_and_generic
      - add_directory_level_CLAUDE_md_files_for_local_context
      - directory_rules_extend_not_replace_root_rules
    long_docs_pattern:
      - put_detailed_sections_in_docs_subfolder
      - reference_paths_from_root_with_one_line_descriptions
  docs_index:
    - path: docs/
      description: optional_long_form_docs_referenced_from_CLAUDE_files
    - path: docs/PLAN.md
      description: year_long_training_program_spec_and_curriculum_phases

architecture:
  project: personal_training_program_for_the_coming_year
  tech:
    primary_language: TypeScript
    notes:
      - repo_currently_minimal_add_details_as_code_is_added
  layout_conventions:
    - root_contains_high_level_guidance_only
    - subdirectories_can_define_their_own_CLAUDE_md_with_local_architecture_and_rules

git_commit_style:
  principles:
    - atomic_commits
    - single_line_subject_only
    - describe_why_not_what
  format:
    subject_template: "<why_summary> with Claude Code"
  examples:
    - "clarify training plan structure with Claude Code"
    - "reduce duplication in workout generator with Claude Code"

code_style:
  language:
    - use_TypeScript_for_all_code_files
  functions:
    - use_function_declarations_for_top_level_functions_not_arrow_functions
  apis:
    - use_object_parameters_to_avoid_argument_ordering_mistakes
  mutability:
    - prefer_const_over_let
    - prefer_ternary_expressions_instead_of_reassignment

common_mistakes_to_track_and_fix:
  instructions:
    - if_the_same_mistake_repeats_add_it_here_with_prevention_steps
    - keep_this_section_short_and_actionable
  known_issues: []
