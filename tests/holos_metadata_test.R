

context("Testing Holos' metadata functions")

test_that("Metadata is returned as expected", {
	 expect_is(about_bee(type = "data"), "data.frame")
	 expect_true(nrow(about_bee(type = "data")) == 5)
	 expect_true(ncol(about_bee(type = "data")) == 2)
	 expect_is(about_bee(type = "meta-data"), "data.frame")
	 expect_is(about_bee(type = "actions"), "data.frame")
	 expect_is(about_bee(type = "data", as.df = FALSE), "list")
	 expect_is(about_bee(type = "meta-data", as.df = FALSE), "list")
	 expect_is(about_bee(type = "actions", as.df = FALSE), "list")
})