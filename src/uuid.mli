(** Implements universally unique identifiers based on version 3 of the UUID
    specification.  Identifier generation is thread safe, and fast.
*)

open! Import

(** When [am_running_inline_test], [sexp_of_t] shows all zeros (the nil UUID). *)
type t [@@deriving hash, sexp_of]

include Identifiable.S with type t := t
include Invariant.S    with type t := t

(** [create ()] returns a new [t] guaranteed to not be equal to any other UUID generated
    by any process anywhere. *)
val create : unit -> t

(** [to_string_hum t] is like [to_string], except when [am_running_inline_test], in
    which case it shows all zeros (the nil UUID). *)
val to_string_hum : t -> string

module Stable : sig
  module V1 : sig
    type nonrec t = t [@@deriving bin_io, compare, hash, sexp]
    val for_testing : t
  end
end
