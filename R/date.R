#' Year month string to date
#' @param ym ym
#' @param day day
#' @importFrom lubridate ymd
#' @importFrom stringr str_pad
#' @export
ym_to_date <- function(ym = c(200902, 201912), day = 1){
  ymd(paste0(ym, str_pad(day, 2, pad = "0")))
}

#' Year month string to date
#' http://stackoverflow.com/questions/1995933/number-of-months-between-two-dates/26640698#26640698
#' @param ym ym
#' @param ym2 ym2
#' @importFrom lubridate year month
#' @export
ym_diff <- function(ym = c(200902, 201912), ym2 = c(200901, 201712)) {

  ed <- ym_to_date(ym)
  sd <- ym_to_date(ym2)

  12 * (year(ed) - year(sd)) + (month(ed) - month(sd))

}

#' Year month to semester, quarter, trimester
#' @param ym ym
#' @param ng number of groups.
#' @export
ym_div <- function(ym = format(ymd(20170101) + months(0:11), "%Y%m"), ng = 4) {

  stopifnot(ng %in% c(2,3,4,6))

  months_per_group <- 12/ng

  cuts <- (seq(1, 12/months_per_group) - 1) * months_per_group + 1

  ymd <- ym_to_date(ym)

  ms <- lubridate::month(ymd)

  new_ms <- cut(ms, breaks = unique(c(cuts, 12)),
                labels = unique(cuts), include.lowest = TRUE, right = FALSE)
  new_ms <- as.character(new_ms)
  new_ms <- as.numeric(new_ms)

  lubridate::month(ymd) <- new_ms

  format(ymd, "%Y%m")

}


