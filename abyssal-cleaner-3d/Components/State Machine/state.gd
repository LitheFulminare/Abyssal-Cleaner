@abstract class_name State extends Node

signal transitioned

@abstract
func enter() -> void

@abstract
func exit() -> void

@abstract
func update(delta: float) -> void

@abstract
func physics_update(delta: float) -> void
