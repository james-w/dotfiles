call jmacs#bindings#register_call_binding('golden ratio', ':GoldenRatioToggle<CR>', g:jmacs_uitoggles_group, 'g')
if !get(g:, 'enable_golden_ratio', 0)
    GoldenRatioToggle
endif
