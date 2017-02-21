% -*- matlab -*-

function uniq_classes = cl_uniq_classes(classes);

ids = [classes(:).id];
[uniq_ids, indicator] = unique(ids);
uniq_classes = classes(indicator);
