#' @title Abstract measure class
#'
#' @description
#' Abstraction for performance measures.
#'
#' Predefined measures are stored in [mlr_measures].
#'
#' @section Usage:
#' ```
#' m = Measure$new(id)
#' m$id
#' m$packages
#' m$task_types
#' m$calculate(experiment)
#' m$range
#' m$minimize
#' ```
#'
#' @section Arguments:
#' * `id` (`character(1)`):
#'   identifier for this object.
#' * `experiment` ([Experiment]):
#'   Experiment to work on.
#'
#' @section Details:
#' `$new()` creates a new object of class [Measure].
#'
#' `$id` (`character(1)`) stores the identifier of the object.
#'
#' `$packages` (`character(1)`) stores the names of required packages.
#'
#' `$task_types` (`character`) stores the class names of tasks this measure can operate on.
#'
#' `$range` (`numeric(2)`) stores the numeric range of feasible measure values.
#'
#' `$minimize` (`logical(1)`) indicates if the good values are reached via minimization.
#'
#' `$calculate` (`funcion`) does the actual work.
#'
#' @name Measure
#' @keywords internal
#' @family Measure
#' @examples
#' mlr_measures$get("mmce")
NULL

#' @include helper_R6.R
#' @export
Measure = R6Class("Measure", cloneable = FALSE,
  public = list(
    id = NULL,
    task_types = NULL,
    range = NULL,
    minimize = NULL,
    packages = NULL,


    initialize = function(id, task_types, range, minimize, packages = character(0L)) {
      self$id = assert_id(id)
      self$task_types = assert_subset(task_types, capabilities$task_types, empty.ok = FALSE)
      self$range = assert_range(range)
      self$minimize = assert_flag(minimize)
      self$packages = assert_packages(packages)
    },

    calculate = method_not_implemented
  )
)

assert_measure = function(measure) {
  assert_r6(measure, "Measure")
}