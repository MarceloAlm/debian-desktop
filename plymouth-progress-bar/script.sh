# This theme is based on Micheal Bearly's Apple Mac Plymouth Bar: https://www.opencode.net/mikebearly/apple-mac-plymouth
# more info https://wiki.gentoo.org/wiki/User:DerpDays/Plymouth/Theming

fun dialog_setup() {
    local.box;
    local.lock;
    local.entry;
    
    box.image = Image("box.png");
    lock.image = Image("lock.png");
    entry.image = Image("entry.png");
    
    box.sprite = Sprite(box.image);
    box.x = ((Window.GetX() + Window.GetWidth()) / 2) - (box.image.GetWidth() / 2);
    box.y = (Window.GetY() + (Window.GetHeight() * 0.9) - (box.image.GetHeight() / 2));
    box.z = 10000;
    box.sprite.SetPosition(box.x, box.y, box.z);
    
    lock.sprite = Sprite(lock.image);
    lock.x = box.x + (box.image.GetWidth() / 2) - ((lock.image.GetWidth() + entry.image.GetWidth()) / 2);
    lock.y = box.y + (box.image.GetHeight() / 2) - (lock.image.GetHeight() / 2);
    lock.z = box.z + 1;
    lock.sprite.SetPosition(lock.x, lock.y, lock.z);
    
    entry.sprite = Sprite(entry.image);
    entry.x = lock.x + lock.image.GetWidth();
    entry.y = box.y + (box.image.GetHeight() / 2) - (entry.image.GetHeight() / 2);
    entry.z = box.z + 1;
    entry.sprite.SetPosition(entry.x, entry.y, entry.z);
    
    global.dialog.box = box;
    global.dialog.lock = lock;
    global.dialog.entry = entry;
    global.dialog.bullet_image = Image("bullet.png");
    dialog_opacity(1);
}
    
fun dialog_opacity(opacity) {
    dialog.box.sprite.SetOpacity(opacity);
    dialog.lock.sprite.SetOpacity(opacity);
    dialog.entry.sprite.SetOpacity(opacity);
    
    for (index = 0; dialog.bullet[index]; index++) {
        dialog.bullet[index].sprite.SetOpacity(opacity);
    }
}

fun display_normal_callback() {
    global.status = "normal";
    
    if (global.dialog) {
        dialog_opacity(0);
    }
}

fun display_password_callback(prompt, bullets) {
    global.status = "password";
    
    if (!global.dialog) {
        dialog_setup();
    } else {
        dialog_opacity(1);
    }
    
    for(index = 0; dialog.bullet[index] || index < bullets; index++) {
        if (!dialog.bullet[index]) {
            dialog.bullet[index].sprite = Sprite(dialog.bullet_image);
            dialog.bullet[index].x = dialog.entry.x + (index * dialog.bullet_image.GetWidth());
            dialog.bullet[index].y = dialog.entry.y + (dialog.entry.image.GetHeight() / 2) - (dialog.bullet_image.GetHeight() / 2);
            dialog.bullet[index].z = dialog.entry.z + 1;
            dialog.bullet[index].sprite.SetPosition(dialog.bullet[index].x, dialog.bullet[index].y, dialog.bullet[index].z);
        }
        
        if ((index < bullets) && (index <= 32)) {
            dialog.bullet[index].sprite.SetOpacity(1);
        } else {
            dialog.bullet[index].sprite.SetOpacity(0);
        }
    }
}

fun quit_callback() {
    logo.sprite.SetOpacity(1);
}

fun display_message_callback(text) {
    message_image = Image.Text(text, 1, 1, 1);
    message_sprite.x = (((Window.GetX() + Window.GetWidth()) / 2) - (message_image.GetWidth() / 2));

    message_sprites[message_sprite_count] = Sprite(message_image);
    message_sprites[message_sprite_count].text = text;

    message_sprites[message_sprite_count].SetPosition(message_sprite.x, message_sprite_y, 10000);
    # message_sprite_count++;
    # message_sprite_y += my_image.GetHeight();
}

fun hide_message_callback(text) {
    for (i = 0; i < message_sprite_count; i++) {
        if (message_sprites[i].text == text) {
            message_sprites[i] = NULL;
        }
    }
}

Window.SetBackgroundTopColor(0, 0, 0);
Window.SetBackgroundBottomColor(0, 0, 0);

background.image = Image("background.png");
background.image_scaled = background.image.Scale(Window.GetWidth(), Window.GetHeight());
background.sprite = Sprite(background.image_scaled);
background.sprite.SetX(0);
background.sprite.SetY(0);
background.sprite.SetOpacity(1);

logo.image = Image("logo.png");
logo.sprite = Sprite(logo.image);
logo.sprite.SetX(((Window.GetX() + Window.GetWidth()) / 2) - (logo.image.GetWidth() / 2));
logo.sprite.SetY(((Window.GetY() + Window.GetHeight()) / 2) - (logo.image.GetHeight() / 2));
logo.sprite.SetOpacity(1);

progress_box.image = Image("progress-box.png");
progress_box.sprite = Sprite(progress_box.image);
progress_box.x = Window.GetX() + (Window.GetWidth() / 2) - (progress_box.image.GetWidth() / 2);
progress_box.y = Window.GetY() + (Window.GetHeight() * 0.8) - (progress_box.image.GetHeight() / 2);

progress_bar.original_image = Image("progress-bar.png");
progress_bar.sprite = Sprite();
progress_bar.x = Window.GetX() + (Window.GetWidth() / 2) - (progress_bar.original_image.GetWidth() / 2);
progress_bar.y = Window.GetY() + (Window.GetHeight() * 0.8) - (progress_box.image.GetHeight() / 2) + ((progress_box.image.GetHeight() - progress_bar.original_image.GetHeight()) / 2);

message_sprites = [];
message_sprite_count = 0;
message_sprite_y = (progress_bar.y + progress_box.image.GetHeight()*2);


fun progress_callback(duration, progress) {
    progress_bar.image = progress_bar.original_image.Scale(progress_bar.original_image.GetWidth(progress_bar.original_image) * progress, progress_bar.original_image.GetHeight());
    progress_bar.sprite.SetImage(progress_bar.image);
}

fun boot_complete() {
    progress_bar.sprite.SetImage(progress_bar.original_image);
}

status = "normal";

Plymouth.SetDisplayNormalFunction(display_normal_callback);
Plymouth.SetDisplayPasswordFunction(display_password_callback);
Plymouth.SetQuitFunction(quit_callback);
Plymouth.SetDisplayMessageFunction(display_message_callback);
Plymouth.SetHideMessageFunction(hide_message_callback);



if (Plymouth.GetMode() == "boot") {
    progress_box.sprite.SetPosition(progress_box.x, progress_box.y, 0);
    progress_bar.sprite.SetPosition(progress_bar.x, progress_bar.y, 1);

    Plymouth.SetBootProgressFunction(progress_callback);
    Plymouth.SetQuitFunction(boot_complete);
}

if (Plymouth.GetMode() == "shutdown") {
}
