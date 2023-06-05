scriptDir <- getwd()
projectDir <- dirname(scriptDir)
libDir <- file.path(projectDir, "lib")
if (!dir.exists(libDir)) {
    dir.create(libDir)
}
pkgDir <- file.path(projectDir, "pkg")
if (!dir.exists(pkgDir)) {
    dir.create(pkgDir)
}
dataDir <- file.path(projectDir, "data")
if (!dir.exists(dataDir)) {
    dir.create(dataDir)
}
outDir <- file.path(projectDir, "outputs")
if (!dir.exists(outDir)) {
    dir.create(outDir)
}
figDir <- file.path(outDir, "figures")
if (!dir.exists(figDir)) {
    dir.create(figDir)
}
if (!dir.exists(file.path(figDir, "ch02"))) {
    dir.create(file.path(figDir, "ch02"), recursive = TRUE)
}
