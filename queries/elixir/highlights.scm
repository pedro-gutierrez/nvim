;; extends

;; functions with no arguments
(call
   target: (identifier) @keyword
   (arguments
     [
       (identifier) @function
       (binary_operator
         left: (identifier) @function
         operator: "when")
     ])
   (#match? @keyword "^(def|defdelegate|defguard|defguardp|defmacro|defmacrop|defn|defnp|defp)$"))
