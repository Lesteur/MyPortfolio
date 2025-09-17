/// @description Textbox parameters
textbox_width = 288
textbox_height = 76

position_x = 16
position_y = 236 - textbox_height

border_text_x = 13
border_text_y = 10

line_sep = 18
line_width = textbox_width - border_text_x*2

if global.world == 0
	textbox_sprite = spr_box_menu_light
else
	textbox_sprite = spr_box_menu_dark

textbox_image = 0
textbox_image_spd = 0.2

array_objects = []
array_sprites = []

destroy = true

//main text
array = []
array_text_sound = []
array_text = []
array_text_misc = []
array_text_length = []
array_text_x_offset = []
array_speaker_sprite = []
array_text_wait = []

array_sub1 = []
array_text_sub1 = []
array_text_misc_sub1 = []
array_text_x_offset_sub1 = []
array_speaker_sprite_sub1 = []

array_sub2 = []
array_text_sub2 = []
array_text_misc_sub2 = []
array_text_x_offset_sub2 = []
array_speaker_sprite_sub2 = []

array_sub3 = []
array_text_sub3 = []
array_text_misc_sub3 = []
array_text_x_offset_sub3 = []
array_speaker_sprite_sub3 = []

sub_x1 = 0
sub_y1 = 0

sub_x2 = 0
sub_y2 = 0

sub_x3 = 0
sub_y3 = 0

sub_avance = -3

page = 0
page_number = 0

draw_char = 0
text_progress = 0
text_speed = 1.6
speed_voice = 2
time_voice = 0
time_wait = 0

dark_spr = 0
dark_a = 0.1

array_text_choice = []
array_text_misc_choice = []
array_x_choice = [9 + border_text_x, textbox_width - border_text_x, textbox_width/2, textbox_width/2]
array_y_choice = [textbox_height/2, textbox_height/2, 3, textbox_height - 4]
array_halign_choice = [fa_left, fa_right, fa_center, fa_center]
array_valign_choice = [fa_middle, fa_middle, fa_top, fa_bottom]

nb_choice = 0
choice = -1
choice_final = -1

current_voice = noone

text_end = false
setup = false

draw_set_font(global.main_font)
draw_set_valign(fa_top)
draw_set_halign(fa_left)